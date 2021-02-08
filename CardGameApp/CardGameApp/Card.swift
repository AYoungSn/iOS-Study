//
//  Card.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/01/31.
//

import Foundation

class Card {

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
        case ace = "A"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case eleven = "J"
        case twelve = "Q"
        case thirteen = "K"
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
        return result + self.num.rawValue
    }
}
