//
//  CardDeck.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/02/01.
//

import Foundation

protocol DeckProto {
    func count() -> Int
    mutating func shuffle()
    mutating func removeOne() -> Card
    mutating func reset()
}

struct CardDeck: DeckProto {
    private var cardDeck: [Card] = []

    init() {
        reset()
        print("카드 전체를 초기화했습니다")
        print("총 \(self.cardDeck.count)장의 카드가 있습니다.")
    }

    func count() -> Int {
        print("총 \(self.cardDeck.count)장의 카드가 남아있습니다.")
        return self.cardDeck.count
    }

    mutating func shuffle() {
        print("전체 \(self.cardDeck.count)장의 카드를 섞었습니다.")
        self.cardDeck.shuffle()
    }

    mutating func removeOne() -> Card {
        let pick = self.cardDeck.removeLast()
        print("총 \(self.cardDeck.count)장의 카드가 남아있습니다.")
        return pick
    }

    mutating func reset() {
        if self.cardDeck.count != 0 {
            cardDeck.removeAll()
        }
        for oneSuit in [Card.Suits.clubs, Card.Suits.heart, Card.Suits.diamond, Card.Suits.spade] {
            for oneRank in Card.Ranks.allCases {
                cardDeck.append(Card(oneSuit, oneRank))
            }
        }
        cardDeck.append(Card(Card.Suits.joker, Card.Ranks.ace))
    }
}
