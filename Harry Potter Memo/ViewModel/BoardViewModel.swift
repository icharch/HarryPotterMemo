//
//  CardViewModel.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 16/03/2023.
//

import Foundation
extension Card: Hashable {}

enum Card {
    case image(CardModel), description(CardModel)
}

class BoardViewModel: ObservableObject {
    
    @Published private(set) var cards: [Card] = []
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    func flip(card: Card) {
        switch card {

        case let .image(model):
            print(model)
        case let .description(model):
            print(model)
        }
    }
}

extension BoardViewModel {
    // MARK: Networking
    // TODO: - Move it to service layer in the future.
    func fetchData() async {
        do {
            guard let url = URL(string: "https://hp-api.onrender.com/api/characters")
            else { fatalError("Missing URL") }

            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode([CardModel].self, from: data)
            let newDecodedData = decodedData[0 ... 24]

            DispatchQueue.main.async {
                var randomElements = [CardModel]()
                while randomElements.count < 6 {
                    if let randomElement = newDecodedData.randomElement(), !randomElements.contains(where: { $0.id == randomElement.id })
                    {
                        randomElements.append(randomElement)
                    }
                }
                self.cards = randomElements.map { [Card.image($0), Card.description($0)] }.flatMap { $0 }.shuffled()
                print(self.cards)
            }
        } catch {
            print("Error fetching data from the website: \(error)")
        }
    }
}
