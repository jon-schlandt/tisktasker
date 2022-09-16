//
//  Utility.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/11/22.
//

import Foundation

class Utility {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: Date())
    }
    
    static func convertToDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.date(from: dateString)
    }
}
