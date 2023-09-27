//
//  CalendarView.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/3/13.
//

import SwiftUI

public extension Date {
    var minute: Int {
        Calendar.current.component(.minute, from: self)
    }
    var minuteString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter.string(from: self)
    }
    var hour: Int {
        Calendar.current.component(.hour, from: self)
    }
    var hourString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: self)
    }
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    var weekVeryShortString: String {
        let index = Calendar.current.component(.weekday, from: self)
        let weekday = DateFormatter().veryShortWeekdaySymbols[index-1]
        return weekday
    }
    var weekShortString: String {
        let index = Calendar.current.component(.weekday, from: self)
        let weekday = DateFormatter().shortWeekdaySymbols[index-1]
        return weekday
    }
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    var monthString: String {
        let month = Calendar.current.component(.month, from: self)
        let monthString = DateFormatter().monthSymbols[month - 1]
        return monthString
    }
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    var chineseDayString: String {
        let index = Calendar(identifier: .chinese).component(.day, from: self)
        let day = ChineseFestivals.days[index-1]
        return day
    }
    var chineseWeekString: String {
        let index = Calendar(identifier: .chinese).component(.weekday, from: self)
        let weekday = ChineseFestivals.weeks[index-1]
        return weekday
    }
    var chineseMonthString: String {
        let index = Calendar(identifier: .chinese).component(.month, from: self)
        let month = ChineseFestivals.months[index-1]
        return month
    }
    var chineseYearString: String {
        "\(Calendar(identifier: .chinese).component(.year, from: self))"
    }
    
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

public extension Calendar {
    func startOfMinute(for date: Date) -> Date {
        let components = self.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let date = self.date(from: components)!
        return date
    }
    func endOfDay(for date: Date) -> Date {
        let components = DateComponents(day: 1, second: -1)
        return self.date(byAdding: components, to: startOfDay(for: date))!
    }
    func startOfWeek(for date: Date) -> Date {
        let components = dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        return self.date(from: components)!
    }
    func endOfWeek(for date: Date) -> Date {
        let components = DateComponents(day: 7, second: -1)
        return self.date(byAdding: components, to: self.startOfWeek(for: date))!
    }
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.month, .year], from: date)
        return self.date(from: components)!
    }
    func endOfMonth(for date: Date) -> Date {
        let components = DateComponents(month: 1, second: -1)
        return self.date(byAdding: components, to: self.startOfMonth(for: date))!
    }
    func startOfYear(for date: Date) -> Date {
        let components = dateComponents([.year], from: date)
        return self.date(from: components)!
    }
    func endOfYear(for date: Date) -> Date {
        let components = DateComponents(year: 1, second: -1)
        return self.date(byAdding: components, to: self.startOfYear(for: date))!
    }
}
