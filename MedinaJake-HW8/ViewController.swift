//
//  ViewController.swift
//  MedinaJake-HW8
//
//  Created by Jake Medina on 11/1/23.
//
//  Project: MedinaJake-HW8
//  EID: jrm7784
//  Course: CS371L

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let imageNames = ["uttower", "ut"]
    var selectedImageIndex = 0
    var clickCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: imageNames[selectedImageIndex])
        
        // ask for notification access
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted, error) in
            if granted {
                print("Notification access granted.")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        clickCount += 1
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                self.imageView.alpha = 0.0
            },
            completion: {
                finished in
                    self.selectedImageIndex = self.selectedImageIndex == 0 ? 1 : 0
                    self.imageView.image = UIImage(named: self.imageNames[self.selectedImageIndex])
                    UIView.animate(
                        withDuration: 1.0,
                        delay: 0.0,
                        options: .curveEaseIn,
                        animations: {
                            self.imageView.alpha = 1.0
                        }
                    )
            }
        )
        
        if (clickCount % 4 == 0) {
            // create content
            let content = UNMutableNotificationContent()
            content.title = "Click Count"
            content.subtitle = "We're watching your clicks!!!"
            content.body = "You have clicked \(clickCount) times"
            content.sound = UNNotificationSound.default
            
            // create trigger
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
            
            // create request
            let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: trigger)
            
            // dispatch
            UNUserNotificationCenter.current().add(request)
        }
    }
    
}

