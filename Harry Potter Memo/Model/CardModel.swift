//
//  CardModel.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 16/03/2023.
//

import Foundation

struct CardModel: Identifiable, Codable, Hashable {
    static func == (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    var id: String
    var name: String
    var house: String
    var ancestry: Ancestry
    var patronus: String
    var image: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case house
        case patronus
        case ancestry
        case image
    }

    enum Ancestry: String, Codable {
        case none = ""
        case halfBlood = "half-blood"
        case pureBlood = "pure-blood"
        case muggle
        case muggleborn
        case squib
        case halfVeela = "half-veela"
        case quarterVeela = "quarter-veela"

        var description: String {
            switch self {
            case .none:
                return ""
            case .halfBlood:
                return "Half Blood"
            case .pureBlood:
                return "Pure Blood"
            case .muggle:
                return "Muggle"
            case .muggleborn:
                return "Muggleborn"
            case .squib:
                return "Squib"
            case .halfVeela:
                return "Half Veela"
            case .quarterVeela:
                return "Quarter Veela"
            }
        }
    }
}

