//
//  Date+Extension.swift
//  WidgetDemo
//
//  Created by run on 2025/2/7.
//

import Foundation

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
    
    var monthDisplayFormat: String {
        self.formatted(.dateTime.month(.wide))
    }
}
