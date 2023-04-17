//
//  CardViewModel.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 16/03/2023.
//

import Foundation

struct PlayerHighscore: Codable, Identifiable {
    let id: UUID
    let name: String
    let time: Int
}

class BoardViewModel: ObservableObject {
    @Published private(set) var cards: [CardViewModel] = []
    @Published var score = 0
    @Published var timer: Timer? = nil
    @Published var playTimeInSeconds: Int = 0
    private let highscoreManager: HighscoreManager = .init()

    var highscores: [PlayerHighscore] {
        highscoreManager.highscores
    }

    var formattedPlayTime: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter.string(from: TimeInterval(playTimeInSeconds))
    }

    var cardToMatch: CardViewModel?
    private let service: CardsServicable

    init() {
        service = CardsService()
        Task {
            await fetchData()
        }
    }
}

extension BoardViewModel {
    
    // MARK: FUNCTIONS

    func didFlip(card: CardViewModel) {
        guard cards.filter({ $0.isFlipped && !$0.isMatched }).count < 2 else { return }
        card.isFlipped = true

        if cardToMatch == nil {
            cardToMatch = card
        } else {
            // second card is flipped
            if cardToMatch?.name == card.name {
                cardToMatch?.isMatched = true
                card.isMatched = true
                cardToMatch = nil
                score += 1
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    card.isFlipped = false
                    if !(self?.cardToMatch?.isMatched ?? false) {
                        self?.cardToMatch?.isFlipped = false
                        self?.cardToMatch = nil
                    }
                }
            }
        }
        if isGameResolved() {
            highscoreManager.addResult(time: playTimeInSeconds)
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] tempTimer in
            self?.playTimeInSeconds += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func isGameResolved() -> Bool {
        return !cards.contains(where: { !$0.isMatched })
    }

    func restart() {
        cards.forEach({ card in
            card.isMatched = false
            card.isFlipped = false
        })
        cards.shuffle()
        score = 0
        playTimeInSeconds = 0
    }

    func fetchData() async {
        do {
            let cards = try await service.fetchCards()
            await MainActor.run {
                self.cards = cards.map { card in [
                    CardViewModel(from: card, cardType: .image, didFlipCard: didFlip(card:)),
                    CardViewModel(from: card, cardType: .description, didFlipCard: didFlip(card:)),
                ] }
                .flatMap { $0 }
                .shuffled()
            }
        } catch {
            print("error")
        }
    }
}

protocol CardsServicable {
    func fetchCards() async throws -> [CardModel]
}

class CardsService: CardsServicable {
    func fetchCards() async throws -> [CardModel] {
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters")
        else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode([CardModel].self, from: data)
        let newDecodedData = decodedData[0 ... 2]
        return Array(newDecodedData)
    }
}
