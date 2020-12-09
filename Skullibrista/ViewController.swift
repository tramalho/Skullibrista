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
    private var isMoving = false
    private var gameTimer: Timer?
    private var startDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameover.isHidden = true
        instrunctions.isHidden = false
        
        street.frame.size.width = view.frame.size.width * 2
        street.frame.size.height = street.frame.size.width * 2
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
        isMoving = false
        instrunctions.isHidden = true
        startDate = Date()
        
        self.player.transform = CGAffineTransform(rotationAngle: 0)
        self.street.transform = CGAffineTransform(rotationAngle: 0)
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
                
                if let data = data {
                    print("x: \(data.gravity.x), y: \(data.gravity.y), z: \(data.gravity.z)")
                    let angle = atan2(data.gravity.x, data.gravity.y) - .pi
                    self.player.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
                    
                    if !self.isMoving {
                       self.checkGameover()
                    }
                }
            }
        }
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true, block: { (timer) in
            self.rotateWorld()
        })
    }
    
    private func checkGameover() {
        let worldAngle = atan2(Double(street.transform.a), Double(street.transform.b))
        let playerAngle = atan2(Double(player.transform.a), Double(player.transform.b))
        
        if abs(worldAngle - playerAngle) > 0.25 {
            gameTimer?.invalidate()
            gameover.isHidden = false
            motionManager.stopDeviceMotionUpdates()
            
            if let startDate = startDate {
                let intervalPlayed = round(Date().timeIntervalSince(startDate))
                timePlayed.text = "Você jogou durante \(intervalPlayed)"
            }
        }
    }
    
    private func rotateWorld() {
        self.isMoving = true
        let randomAngle = Double(arc4random_uniform(120))/100 - 0.6
        UIView.animate(withDuration: 0.75, animations: {
            self.street.transform = CGAffineTransform(rotationAngle: CGFloat(randomAngle))
        }) { (success) in
            self.isMoving = false
        }
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        start()
    }
}

