//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Jeff Smith on 9/28/14.
//  Copyright (c) 2014 Jeff Smith. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var inboxScrollView: UIScrollView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var leftMessageIconImageView: UIImageView!
    @IBOutlet weak var rightMessageIconImageView: UIImageView!
    
    // Define color variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inboxScrollView.contentSize = CGSize(width: 320, height: (1202 + 86 + 37 + 42))

        var messagePanRecognizer = UIPanGestureRecognizer(target: self, action: "onMessagePan:")
        messageView.addGestureRecognizer(messagePanRecognizer)
        
    }

    @IBAction func onMessagePan(messagePanRecognizer: UIPanGestureRecognizer) {
        
        var point = messagePanRecognizer.locationInView(view)
        var transform = messagePanRecognizer.translationInView(view)
        
        if messagePanRecognizer.state == UIGestureRecognizerState.Changed {
            
            var color: UIColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1)

            leftMessageIconImageView.alpha = (transform.x/75) - 0.1
            rightMessageIconImageView.alpha = (-transform.x/75) - 0.1
            
            self.messageImageView.center.x = messageView.center.x + transform.x

            if self.messageImageView.frame.origin.x > 60 {
                println("Archive")
//                leftMessageIconImageView.alpha = 0
                color = UIColor(red: 0.38, green: 0.85, blue: 0.38, alpha: 1)
            }

            if self.messageImageView.frame.origin.x > 260 {
                println("Delete")
                color = UIColor(red: 0.93, green: 0.33, blue: 0.05, alpha: 1)
                leftMessageIconImageView.image = UIImage(named: "delete_icon")
            }
            
            
            if self.messageImageView.frame.origin.x < -60 {
                println("Later")
//                rightMessageIconImageView.alpha = 0
                color = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
            }
            

            if self.messageImageView.frame.origin.x < -260 {
                println("Categorize")
                color = UIColor(red: 0.84, green: 0.65, blue: 0.45, alpha: 1)
                rightMessageIconImageView.image = UIImage(named: "list_icon")
            }
            
            self.messageView.backgroundColor = color
            
        } else if messagePanRecognizer.state == UIGestureRecognizerState.Ended {
            if self.messageImageView.frame.origin.x > 60 {
                println("Archive Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                        self.messageImageView.frame.origin.x += 320
                }, completion: nil)
            }
            
            if self.messageImageView.frame.origin.x > 260 {
                println("Delete Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                    self.messageImageView.frame.origin.x += 320
                }, completion: nil)
            }
            
            if self.messageImageView.frame.origin.x < -60 {
                println("Later Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                        self.messageImageView.frame.origin.x -= 320
                }, completion: nil)
            }
            
            
            if self.messageImageView.frame.origin.x < -260 {
                println("Categorize Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                        self.messageImageView.frame.origin.x -= 320
                }, completion: nil)
            }
        }
    }
}
