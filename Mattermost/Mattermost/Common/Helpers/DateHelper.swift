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
        let minutes = Calendar.current.dateComponents([Calendar.Component.minute], from: date, to: Date()).minute ?? 0
        if minutes < 60 * 24 {
            dateFormatter.dateFormat = "hh:mm a"
        } else {
            dateFormatter.dateFormat = "dd.MM.YYYY"
        }
        return dateFormatter.string(from: date)
    }
    
}
