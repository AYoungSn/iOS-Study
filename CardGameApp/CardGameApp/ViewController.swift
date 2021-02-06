//
//  ViewController.swift
//  CardGameApp
//
//  Created by 안영선 on 2021/01/27.
//

import UIKit

class ViewController: UIViewController {

    var cardType = UISegmentedControl(items: ["7 Cards", "5 Cards"])
    var playerSelect = UISegmentedControl(items: ["2명", "3명", "4명"])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern.png")!)

//        makeCard()
//
//        let card = Card(Card.Suits.heart, Card.Ranks.ace)
//        printCardInfo(card)
//
//        card.num = Card.Ranks.twelve
//        printCardInfo(card)
//
//        var poker = CardGame(7, 3)
//        poker.gameStart()
//        poker.printCardStatus()
//
//        poker = CardGame(5, 3)
//        poker.gameStart()
//        poker.printCardStatus()
        let topPadding = UIApplication.shared.windows[0].safeAreaInsets.top
        cardType.center = CGPoint(x: self.view.frame.width / 2, y: topPadding + 10)
        cardType.backgroundColor = UIColor.clear
        cardType.tintColor = UIColor.white
        cardType.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        cardType.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        cardType.layer.borderWidth = 1.0
        cardType.layer.borderColor = UIColor.white.cgColor
        self.view.addSubview(self.cardType)

        playerSelect.center = CGPoint(x: self.view.frame.width / 2, y: cardType.frame.maxY)
        playerSelect.backgroundColor = UIColor.clear
        playerSelect.tintColor = UIColor.white
        playerSelect.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        playerSelect.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        self.view.addSubview(self.playerSelect)
    }

    func cardTest() {
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
        let width = (self.view.bounds.width - 8) / 7
        let height = width * 1.27
        var imageView: [UIImageView] = []
        var point: CGPoint
        var size: CGSize

        let topPadding = UIApplication.shared.windows[0].safeAreaInsets.top
//        print(UIApplication.shared.windows[0].safeAreaInsets.bottom)
        for i in 0...6 {
            if i - 1 >= 0 {
                point = CGPoint(x: imageView[i - 1].frame.maxX + 4, y: topPadding)
                size = CGSize(width: width - 4, height: height)
                imageView.append(UIImageView(frame: CGRect(origin: point, size: size)))
            } else {
                imageView.append(UIImageView(frame: CGRect(x: view.safeAreaInsets.left + 4, y: topPadding, width: width - 4, height: height)))
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
