//
//  CardViewModel.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 30/03/2023.
//

import Foundation

enum CardType: Hashable {
    case image, description
}

class CardViewModel: ObservableObject, Identifiable {

    let id: UUID
    let cardType: CardType
    let imageURL: String
    @Published var isFlipped: Bool = false
    @Published var isMatched: Bool = false
    @Published var name: String = ""
    @Published var house: String = ""
    @Published var patronus: String = ""
    @Published var ancestry: String = ""
    var didFlipCard: ((CardViewModel) -> Void)
    init(
        from cardModel: CardModel,
        cardType: CardType,
        didFlipCard: @escaping ((CardViewModel) -> Void)
    ) {
        id = UUID()
        name = cardModel.name
        house = cardModel.house
        patronus = cardModel.patronus
        imageURL = cardModel.image
        ancestry = cardModel.ancestry.rawValue
        self.didFlipCard = didFlipCard
        self.cardType = cardType
    }
    
    func cardFlip() {
        self.didFlipCard(self)
    }
}
