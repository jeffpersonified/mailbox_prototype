//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Jeff Smith on 9/28/14.
//  Copyright (c) 2014 Jeff Smith. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var Feed: UIImageView!
    @IBOutlet weak var inboxScrollView: UIScrollView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var leftMessageIconImageView: UIImageView!
    @IBOutlet weak var rightMessageIconImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var rescheduleImageView: UIImageView!
    @IBOutlet var listTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var rescheduleTapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inboxScrollView.contentSize = CGSize(width: 320, height: (1202 + 86 + 37 + 42))
        var messagePanRecognizer = UIPanGestureRecognizer(target: self, action: "onMessagePan:")
        
        messageView.addGestureRecognizer(messagePanRecognizer)
        listTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onListTap")
        listImageView.addGestureRecognizer(listTapGestureRecognizer)
        rescheduleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onRescheduleTap")
        rescheduleImageView.addGestureRecognizer(rescheduleTapGestureRecognizer)
    }
    
    func sendMessage() {
        self.messageView.removeFromSuperview()
        UIView.animateWithDuration(0.25, animations: { self.feedImageView.frame.origin.y = self.feedImageView.frame.origin.y - 86
        }, completion: nil)
        
    }
    
    func onListTap() {
        UIView.animateWithDuration(0.25, animations: {
            self.listImageView.alpha = 0
            }, completion: nil
        )
    }

    func onRescheduleTap() {
        UIView.animateWithDuration(0.25, animations: {
            self.rescheduleImageView.alpha = 0
            }, completion: nil
        )
    }
    
    
    @IBAction func onMessagePan(messagePanRecognizer: UIPanGestureRecognizer) {
        
        var point = messagePanRecognizer.locationInView(view)
        var transform = messagePanRecognizer.translationInView(view)
        
        if messagePanRecognizer.state == UIGestureRecognizerState.Changed {
            
            var color: UIColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1)

            leftMessageIconImageView.alpha = (transform.x / 75) - 0.1
            rightMessageIconImageView.alpha = (-transform.x / 75) - 0.1
            
            self.messageImageView.center.x = messageView.center.x + transform.x

            if self.messageImageView.frame.origin.x > 60 {
                println("Archive")
                color = UIColor(red: 0.38, green: 0.85, blue: 0.38, alpha: 1)
                leftMessageIconImageView.image = UIImage(named: "archive_icon")
            }

            if self.messageImageView.frame.origin.x > 200 {
                println("Delete")
                color = UIColor(red: 0.93, green: 0.33, blue: 0.05, alpha: 1)
                leftMessageIconImageView.image = UIImage(named: "delete_icon")
            }
            
            if self.messageImageView.frame.origin.x < -60 {
                println("Later")
                color = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
                leftMessageIconImageView.image = UIImage(named: "later_icon")
            }
            
            if self.messageImageView.frame.origin.x < -200 {
                println("Categorize")
                color = UIColor(red: 0.84, green: 0.65, blue: 0.45, alpha: 1)
                rightMessageIconImageView.image = UIImage(named: "list_icon")
            }
            
            
            if transform.x > 60 {
                leftMessageIconImageView.frame.origin.x = 15 + transform.x - 60
            }
            
            if transform.x < -60 {
                rightMessageIconImageView.frame.origin.x = 275 + transform.x + 60
            }
            
            self.messageView.backgroundColor = color
            
        } else if messagePanRecognizer.state == UIGestureRecognizerState.Ended {
            if self.messageImageView.frame.origin.x > 60 {
                println("Archive Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                        self.messageImageView.frame.origin.x += 320
                }, completion: { (finished: Bool) in
                    self.sendMessage() })
            } else if self.messageImageView.frame.origin.x > 260 {
                println("Delete Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                        self.messageImageView.frame.origin.x += 320
                }, completion: nil)
            } else if self.messageImageView.frame.origin.x < -60 &&
                      self.messageImageView.frame.origin.x > -260 {
                println("Later Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                        self.messageImageView.frame.origin.x -= 320
                    }, completion: { (finished: Bool) in
                        self.view.bringSubviewToFront(self.rescheduleImageView)
                        UIView.animateWithDuration(0.25, animations: {
                            self.rescheduleImageView.alpha = 1.0
                            }, completion: nil)
                })
            } else if self.messageImageView.frame.origin.x < -260 {
                println("Categorize Ended")
                UIView.animateWithDuration(
                    0.4,
                    animations: {
                        self.messageImageView.frame.origin.x -= 320
                    }, completion: { (finished: Bool) in
                        self.view.bringSubviewToFront(self.listImageView)
                        UIView.animateWithDuration(0.25, animations: {
                            self.rescheduleImageView.alpha = 1.0
                        }, completion: nil)
                })
            
            } else {
                println("Reset Message")
                UIView.animateWithDuration(
                    0.4,
                    delay: 0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 3,
                    options: nil,
                    animations: {
                        self.messageImageView.center.x = self.messageView.center.x
                    },
                    completion: nil)
            }
        }
    }
}
