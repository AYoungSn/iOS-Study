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
//        let bottomPadding = UIApplication.shared.windows[0].safeAreaInsets.bottom

        addButton(y: topPadding + 10, button: cardType, action: #selector(cardtypeChanged(cardtype:)))
        addButton(y: cardType.frame.maxY + playerSelect.frame.midY + 10, button: playerSelect, action: #selector(playerCntChanged(player:)))

//        stackArea = CGSize(width: self.view.bounds.width, height: view.bounds.height - bottomPadding - playerSelect.frame.maxY - 10)
        self.becomeFirstResponder()

//        let x = CGFloat(view.bounds.width / CGFloat(cardCnt + 2))
//        stack.frame = CGRect(origin: CGPoint(x: x / 2, y: playerSelect.frame.maxY + 10), size: stackArea)
        self.view.addSubview(stack)

    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")

    }

    func pokerGame() {
        print("cardCnt: \(cardCnt), playerCnt: \(playerCnt)")
        poker = CardGame(cardCnt, playerCnt)
        poker.gameStart()
        for i in 0..<playerCnt {
            labels.append(UILabel())
            labels[i].text = "Player\(i + 1)"
            labels[i].textColor = .white
            poker.persons[i].addcardView(CGFloat(self.view.bounds.width / CGFloat(cardCnt)))
            makesubView(poker.persons[i].cardList, labels[i])
        }
        labels.append(UILabel())
        labels[playerCnt].text = "Dealer"
        labels[playerCnt].textColor = .white
        stack.addArrangedSubview(labels[playerCnt])
        poker.dealer.addcardView(CGFloat(view.bounds.width / CGFloat(cardCnt + 2)))
        makesubView(poker.dealer.cardList, labels[playerCnt])
    }

    func makesubView(_ imgviews: [UIImageView], _ label: UILabel) {
        let subview = UIStackView()
        subview.axis = .horizontal
        subview.spacing = -7
        subview.alignment = .fill
        subview.distribution = .fillEqually
        subview.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(label)
        for i in 0..<cardCnt {
//            imgviews[i].frame.origin.y = label.frame.maxY
            imgviews[i].heightAnchor.constraint(equalTo: imgviews[i].widthAnchor, multiplier: 1.27).isActive = true
            if i > 0 {
//                imgviews[i].frame.origin.x = imgviews[i - 1].frame.maxX
            }
            subview.addArrangedSubview(imgviews[i])
        }
        self.stack.addArrangedSubview(subview)
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("motionEnded")
        if motion == .motionShake {
            stack.removeFromSuperview()
            stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.spacing = 10
            stack.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(stack)
            stack.topAnchor.constraint(equalTo: playerSelect.bottomAnchor, constant: 15).isActive = true
            stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
            stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
//            stack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
//            let x = CGFloat(view.bounds.width / CGFloat(cardCnt + 2))
//            stack.frame = CGRect(origin: CGPoint(x: x / 2, y: playerSelect.frame.maxY + 10), size: stackArea)
//            stack.backgroundColor = .brown

            print("pokerGame")
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
