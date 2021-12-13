//
//  NSNotification+Extension.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 13.12.2021.
//
import UIKit

extension Notification.Name {
    static let timerNotification = Notification.Name(
       rawValue: "TimerAlarm")
    static let timerIntervalNotification = Notification.Name(rawValue: "TimerPeriodChanged")
}
