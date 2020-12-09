//
//  ViewController.swift
//  Skullibrista
//
//  Created by Thiago Antonio Ramalho on 03/12/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var street: UIImageView!
    @IBOutlet weak var player: UIImageView!
    @IBOutlet weak var gameover: UIView!
    @IBOutlet weak var timePlayed: UILabel!
    @IBOutlet weak var instrunctions: UILabel!
    
    private lazy var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameover.isHidden = true
        instrunctions.isHidden = false
        street.frame.size.width = view.frame.size.width
        street.frame.size.height = view.frame.size.height
        street.center = view.center
        
        player.center = view.center
        
        player.animationImages = []
        
        for i in 0...7 {
            if let image = UIImage(named: "player\(i)") {
                player.animationImages?.append(image)
            }
        }
        
        player.animationDuration = 0.6
        player.startAnimating()

        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (Timer) in
            self.start()
        }
    }
    
    private func start() {
        self.instrunctions.isHidden = true
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
                
                if let data = data {
                    print("x: \(data.gravity.x), y: \(data.gravity.y), z: \(data.gravity.z)")
                    let angle = atan2(data.gravity.x, data.gravity.y) - .pi
                    self.player.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
                }
            }
        }
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
    }
}

