//
//  DateHelper.swift
//  Mattermost
//
//  Created by iOS_Developer on 22.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class DateHelper {

    static func chatTimeStringForDate(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.autoupdatingCurrent
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "hh:mm a"
        } else if calendar.isDateInYesterday(date) {
            return R.string.localizable.timeYesterday()
        } else {
            let calendar = Calendar.autoupdatingCurrent
            let days = calendar.dateComponents([Calendar.Component.day], from: date, to: Date()).day
            if days < 7 {
                dateFormatter.dateFormat = "EEEE"
            } else if days < 365 {
                dateFormatter.dateFormat = "dd MMM"
            } else {
                dateFormatter.dateFormat = "dd.MM.YYYY"
            }
        }
        return dateFormatter.string(from: date)
    }
    
    static func time(forDate date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    static func prettyDateString(forDate date:Date) -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.autoupdatingCurrent
        if calendar.isDateInYesterday(date) {
            return R.string.localizable.timeYesterday()
        } else {
            let calendar = Calendar.autoupdatingCurrent
            let days = calendar.dateComponents([Calendar.Component.day], from: date, to: Date()).day
            if days < 7 {
                dateFormatter.dateFormat = "EEEE"
            } else if days < 365 {
                dateFormatter.dateFormat = "dd MMMM"
            } else {
                dateFormatter.dateFormat = "dd, MMMM YYYY"
            }
        }
        return dateFormatter.string(from: date)
    }
    
    static func fullDateTimeString(forDate date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a, dd, MMMM YYYY"
        return dateFormatter.string(from: date)
    }
}
