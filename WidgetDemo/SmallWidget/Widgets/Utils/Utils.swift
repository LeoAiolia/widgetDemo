//
//  Utils.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/3/12.
//

import Foundation

extension Date {
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier)
    }
    
    //年:2020
    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    
    //月份:2
    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    
    //天:10
    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    
}


//小组件时间刷新相关
extension Date {
    //获取完整时间,2011:07:13
    func getCurrentDayStartHour(_ isDayOf24Hours: Bool)-> Date {
        let components = DateComponents(year: self.year, month: self.month, day: self.day, hour: 0, minute: 0, second: 0)
        return Calendar.current.date(from: components)!
    }
}
