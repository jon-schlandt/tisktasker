//
//  DateUtil.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/11/22.
//

import Foundation

class DateUtil {
    var dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
    }
    
    func convertToDate(from dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }
    
    func formatDate(from date: Date, as format: String = "yyyy-MM-dd") -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
