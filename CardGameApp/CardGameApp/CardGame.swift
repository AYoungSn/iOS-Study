//
//  CardGame.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/02/01.
//

import Foundation

struct CardGame {
    var pokerCard = CardDeck()
    var persons: [Participant] = []
    var dealer: Participant
    let cardCnt: Int
    let personCnt: Int

    init(_ cardcount: Int, _ personCount: Int) {
        self.cardCnt = cardcount
        self.personCnt = personCount
        for _ in 0..<self.personCnt {
            self.persons.append(Participant(cardcount, dealer: false))
        }
        dealer = Participant(cardcount, dealer: true)
    }

    mutating func gameStart() {
        pokerCard.shuffle()
        for i in 0..<self.personCnt {
            for _ in 0..<cardCnt {
                persons[i].addCard(card: pokerCard.removeOne())
            }
        }
        for _ in 0..<cardCnt {
            dealer.addCard(card: pokerCard.removeOne())
        }
    }

    mutating func playerInfo(player: Participant) -> [Card] {
        return player.card
    }

    mutating func printCardStatus() {
        for i in 0..<personCnt {
            print("참가자#\(i + 1) ", terminator: "[")
            print(printCardList(persons[i]), terminator: "]\n")
        }
        print("딜러 ", terminator: "[")
        print(printCardList(dealer), terminator: "]\n")
    }

    mutating func printCardList(_ person: Participant) -> String {
        var result: String = ""
        for i in 0..<cardCnt {
            if i != 0 {
                result += ", "
            }
            result += "\(person.card[i].cardInfo())"
        }
        return result
    }

}
