//
//  Card.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/01/31.
//

import Foundation

class Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.num < rhs.num
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.num == rhs.num
    }

    var suits: Suits
    var num: Ranks

    enum Suits: String, CaseIterable {
        case spade = "♠"
        case heart = "♥"
        case diamond = "♦︎"
        case clubs = "♣︎"
        case joker = "🃏"
    }

    enum Ranks: String, CaseIterable {
        case ace = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case eleven = "11" // J
        case twelve = "12" // Q
        case thirteen = "13" // K
    }

    init(_ suit: Suits, _ num: Ranks) {
        self.suits = suit
        self.num = num
    }

    func cardInfo() -> String {
        var result: String
        switch self.suits {
        case .spade:
            result = "s"
        case .clubs:
            result = "c"
        case .diamond:
            result = "d"
        case .heart:
            result = "h"
        case .joker:
            return "j"
        }
        var rank: String
        switch num.rawValue {
        case "1":
            rank = "A"
        case "11":
            rank = "J"
        case "12":
            rank = "Q"
        case "13":
            rank = "K"
        default:
            rank = num.rawValue

        }
        return result + rank
    }
}

extension Card.Ranks: Comparable {
    static func < (lhs: Card.Ranks, rhs: Card.Ranks) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    static func == (lhs: Card.Ranks, rhs: Card.Ranks) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
