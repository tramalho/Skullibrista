//
//  ViewController.swift
//  Skullibrista
//
//  Created by Thiago Antonio Ramalho on 03/12/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var street: UIImageView!
    @IBOutlet weak var player: UIImageView!
    @IBOutlet weak var gameover: UIView!
    @IBOutlet weak var timePlayed: UILabel!
    @IBOutlet weak var instrunctions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameover.isHidden = true
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
    }
}

