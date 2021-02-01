//
//  ViewController.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/01/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern.png")!)

        makeCard()

        let card = Card(Card.Suits.heart, Card.Ranks.ace)
        printCardInfo(card)

        card.num = Card.Ranks.twelve
        printCardInfo(card)

        test()

    }

    func test() {
        print("> 카드 초기화")
        var cardtest = CardDeck()

        print("> 카드 하나 뽑기")
        printCardInfo(cardtest.removeOne())

        print("> 카드 섞기")
        cardtest.shuffle()

        print("> 카드 하나 뽑기")
        printCardInfo(cardtest.removeOne())

        print("> 카드 하나 뽑기")
        printCardInfo(cardtest.removeOne())

        print("> 카드 하나 뽑기")
        printCardInfo(cardtest.removeOne())
    }

    func makeCard() {
        let width = (self.view.bounds.width - self.view.safeAreaInsets.left - view.safeAreaInsets.right - 8) / 7
        let height = width * 1.27
        var imageView: [UIImageView] = []
        var point: CGPoint
        var size: CGSize

        for i in 0...6 {
            if i - 1 >= 0 {
                point = CGPoint(x: imageView[i - 1].frame.maxX + 4, y: height)
                size = CGSize(width: width - 4, height: height)
                imageView.append(UIImageView(frame: CGRect(origin: point, size: size)))
            } else {
                imageView.append(UIImageView(frame: CGRect(x: view.safeAreaInsets.left + 4, y: height, width: width - 4, height: height)))
            }
        }

        let cardBack = UIImage(named: "card-back.png")
        for imgView in imageView {
            imgView.image = cardBack
            imgView.layer.cornerRadius = 5
            imgView.clipsToBounds = true
            self.view.addSubview(imgView)
        }
    }

    func printCardInfo(_ card: Card) {
        print(card.cardInfo())
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
