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
        let days = Calendar.current.dateComponents([Calendar.Component.day], from: date, to: Date()).day ?? 0
        if days >= 1 {
            dateFormatter.dateFormat = "dd.MM.YYYY"
        } else {
            dateFormatter.dateFormat = "hh:mm a"
        }
        return dateFormatter.string(from: date)
    }
    
}
