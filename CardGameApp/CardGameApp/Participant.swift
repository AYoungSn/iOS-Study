//
//  Participant.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/02/01.
//

import Foundation
import UIKit

struct Participant {
    // card 갯수
    let count: Int
    var card: [Card] = []
    var cardList: [UIImageView] = []
    var dealer: Bool
    var result: String!

    init(_ count: Int, dealer: Bool) {
        self.count = count
        self.dealer = dealer
    }

    mutating func addCard(card: Card) {
        self.card.append(card)
    }

    mutating func addcardView(_ width: CGFloat) {
        print("addcardView")
        for i in 0..<count {
            let image = UIImage(named: card[i].cardInfo())
            cardList.append(UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: width * 1.27))))
            cardList[i].image = image
            cardList[i].layer.cornerRadius = 5
            cardList[i].clipsToBounds = true
        }
    }

    mutating func cardresult() {
        card.sort()

    }
}
