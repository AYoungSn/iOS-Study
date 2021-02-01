//
//  ViewController.swift
//  PhotoFrame
//
//  Created by 안영선 on 2021/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#file, #line, #function, #column)
        self.firstLabel.text = "JK의 사진액자"
        self.firstLabel.textColor = .red
    }

    @IBAction func nextButtonTouched(_ sender: Any) {
        self.firstLabel.textColor = UIColor.blue
        self.firstLabel.backgroundColor = UIColor.yellow
        self.firstLabel.alpha = 0.5
    }
}
