//
//  TimerService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 13.12.2021.
//

import UIKit

class TimerService {
    static let shared = TimerService()
    let notificationCenter = NotificationCenter.default
    
    var timer: Timer?
    var intervalComponent: Calendar.Component = .second
    var interval: Int? = 10
 
    var alarmTimerTime: Date?
    var stopTimerTime: Date?
    var wakeUpTimerTime: Date?
    
    var startTimerTime: Date? {
        didSet {
            self.updateAlarmTimerTime()
            print(" ------ alarmTimerTime = \( self.alarmTimerTime)")
        }
    }
    
    // MARK: - Init
    private init() {
        self.startTimer(fireAt: Date())
        self.addObservers()
    }
    
    deinit {
        self.removeObservers()
    }
    
    func startTimer(fireAt: Date) {
        if self.timer == nil {
            self.startTimerTime = fireAt
            let timer = Timer.init(fireAt: fireAt, interval: Double(self.interval!), target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timer.tolerance = 0.1
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            self.timer = timer
        }
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
        print("Timer stopped!")
    }
    
    // MARK: - Actions
    @objc func updateTimer(sender: Timer) {
        self.startTimerTime = sender.fireDate
        notificationCenter.post(name: NSNotification.Name.timerNotification,
                                        object: nil)
        print(" ALARM ALARM ALARM ALARM ALARM ALARM \(sender.fireDate)")
    }
    
    @objc func appMovedToBackgroundAction(_ notification: Notification?) {
        guard notification != nil else { return }
        
        UserDefaults.standard.set(Date(), forKey: UserDefaultsKey.stopTimerTime.rawValue)
        UserDefaults.standard.set(self.alarmTimerTime, forKey: UserDefaultsKey.alarmTimerTime.rawValue)
        
        self.stopTimer()
  
    }
    
    @objc func appWillEnterForegroundAction(_ notification: Notification?) {
        guard notification != nil else { return }
        self.wakeUpTimerTime = Date()
        self.stopTimerTime = UserDefaults.standard.value(forKey: UserDefaultsKey.stopTimerTime.rawValue) as? Date
        self.alarmTimerTime = UserDefaults.standard.value(forKey: UserDefaultsKey.alarmTimerTime.rawValue) as? Date
        
        if self.stopTimerTime != nil {
            if let wakeUpTime = self.wakeUpTimerTime,
               let stopTime = self.stopTimerTime,
               let alarmTime = self.alarmTimerTime,
               let interval = self.interval {
                
                if let difference = self.timeIntervalInSeconds(lhs: stopTime , rhs: wakeUpTime),
                   difference >= interval {
                    startTimer(fireAt: Date())
                } else {
                    startTimer(fireAt:alarmTime )
                }
            }
        }
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.stopTimerTime.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.alarmTimerTime.rawValue)
    }
    
    @objc func timerIntervalAction(_ notification: Notification?) {
        guard let notification = notification,
              let newInterval = notification.object as? Int,
              let oldInterval = self.interval,
              let startTimer = self.startTimerTime else { return }
        
        let intervalDelta = newInterval - oldInterval

        if intervalDelta != 0 {
            self.interval = newInterval
            self.stopTimer()
            if let newStartTime = Calendar.current.date(byAdding: intervalComponent, value: intervalDelta, to: startTimer) {
                self.startTimer(fireAt: newStartTime)
            }
        }
    }
    
    // MARK: - Private methods
    fileprivate func timeIntervalInSeconds(lhs: Date,
                                           rhs: Date) -> Int? {
        let diffComponents = Calendar.current.dateComponents([.second], from: lhs, to: rhs)
        let seconds = diffComponents.second
        return seconds
    }
    
    fileprivate func updateAlarmTimerTime() {
        guard let startTimerTime = self.startTimerTime,
              let interval = self.interval else { return }
        let calendar = Calendar.current
        self.alarmTimerTime = calendar.date(byAdding: intervalComponent, value: interval, to: startTimerTime)
    }
    
    fileprivate func addObservers() {
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackgroundAction(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillEnterForegroundAction(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(timerIntervalAction(_:)), name: .timerIntervalNotification, object: nil)
    }
    
    fileprivate func removeObservers() {
        notificationCenter.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.removeObserver(self, name: .timerIntervalNotification, object: nil)
    }
}
