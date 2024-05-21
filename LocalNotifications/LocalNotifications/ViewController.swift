//
//  ViewController.swift
//  LocalNotifications
//
//  Created by HTLILI on 21/05/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnRemoveNotification(_ sender: UIButton) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TestID"])
    }
    
    @IBAction func btnTestNotification(_ sender: UIButton) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("granted")
                DispatchQueue.main.sync {
                    self.scheduleNotification()
                }
                
            } else {
                print("denied")
            }
        }
    }
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "SubTitle"
        content.body = "Notification"
        content.badge = 1
        content.sound = .default
        content.userInfo = ["name": "My test name"]
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
//        var component = DateComponents()
//        component.calendar = Calendar.current
//        component.weekday = 1
//        component.hour = 21
//        component.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        let date = datePicker.date
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date), repeats: false)
        let request = UNNotificationRequest(identifier: "TestID", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}

