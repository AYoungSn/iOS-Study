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
    var cardCnt: Int = 7
    var playerCnt: Int = 4
    var poker: CardGame!
    var stack = UIStackView()
    var playerlist: [UIView] = []
    var stackArea: CGSize!
    var labels: [UILabel] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern.png")!)

        let topPadding = UIApplication.shared.windows[0].safeAreaInsets.top
        let bottomPadding = UIApplication.shared.windows[0].safeAreaInsets.bottom

        addButton(y: topPadding + 10, button: cardType, action: #selector(cardtypeChanged(cardtype:)))
        addButton(y: cardType.frame.maxY + playerSelect.frame.midY + 10, button: playerSelect, action: #selector(playerCntChanged(player:)))

        stackArea = CGSize(width: self.view.bounds.width, height: view.bounds.height - bottomPadding - playerSelect.frame.maxY - 10)
        self.becomeFirstResponder()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually

        let x = CGFloat(view.bounds.width / CGFloat(cardCnt + 2))
        stack.frame = CGRect(origin: CGPoint(x: x / 2, y: playerSelect.frame.maxY + 10), size: stackArea)
        self.view.addSubview(stack)

    }

    func pokerGame() {
        poker = CardGame(cardCnt, playerCnt)
        poker.gameStart()
        for i in 0..<playerCnt {
            labels.append(UILabel())
            labels[i].text = "Player\(i + 1)"
            poker.persons[i].addcardView(CGFloat(view.bounds.width / CGFloat(cardCnt + 2)))
            stack.addArrangedSubview(labels[i])
            makesubView(poker.persons[i].cardList, labels[i])
        }
        labels.append(UILabel())
        labels[playerCnt].text = "Dealer"
        stack.addArrangedSubview(labels[playerCnt])
        poker.dealer.addcardView(CGFloat(view.bounds.width / CGFloat(cardCnt + 2)))
        makesubView(poker.dealer.cardList, labels[playerCnt])
    }

    func makesubView(_ imgviews: [UIImageView], _ label: UILabel) {
        let view = UIView()
        for i in 0..<cardCnt {
            imgviews[i].frame.origin.y = label.frame.maxY
            if i > 0 {
                imgviews[i].frame.origin.x = imgviews[i - 1].frame.maxX
            }
            view.addSubview(imgviews[i])
        }
        stack.addArrangedSubview(view)
        stack.spacing = 10
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
//            stack.removeFromSuperview()
            pokerGame()
        }
    }

    func addButton(y: CGFloat, button: UISegmentedControl, action: Selector) {
        button.center = CGPoint(x: self.view.frame.width/2, y: y)
        button.backgroundColor = UIColor.clear
        button.selectedSegmentTintColor = UIColor.white
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: action, for: .valueChanged)
        self.view.addSubview(button)
    }

    @objc func cardtypeChanged(cardtype: UISegmentedControl) {
        var cardCnt: Int!

        switch cardtype.selectedSegmentIndex {
        case 0:
            cardCnt = 7
        case 1:
            cardCnt = 5
        default: return
        }
        self.cardCnt = cardCnt
    }

    @objc func playerCntChanged(player: UISegmentedControl) {
        switch player.selectedSegmentIndex {
        case 0:
            self.playerCnt = 2
        case 1:
            self.playerCnt = 3
        case 2:
            self.playerCnt = 4
        default: return
        }
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
