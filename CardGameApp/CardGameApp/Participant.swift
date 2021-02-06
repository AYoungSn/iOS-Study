//
//  Participant.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/02/01.
//

import Foundation

struct Participant {
    let count: Int
    var card: [Card] = []
    var dealer: Bool

    init(_ count: Int, dealer: Bool) {
        self.count = count
        self.dealer = dealer
    }

    mutating func addCard(card: Card) {
        self.card.append(card)
    }

}
