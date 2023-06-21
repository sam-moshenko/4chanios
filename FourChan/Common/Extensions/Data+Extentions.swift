//
//  Data+Extentions.swift
//  FourChan
//
//  Created by Yeldos Marat on 21.06.2023.
//

import Foundation

extension Date {
    static func fromCustomString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy(E)HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString)
    }
    
    var relativeDateString: String {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: now)
        
        if let days = components.day {
            if days < 1 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                return "\(S.todayAt) \(dateFormatter.string(from: self))"
            } else if days == 1 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                return "\(S.yesterday) \(dateFormatter.string(from: self))"
            } else if days < 7 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E, h:mm a"
                return "\(S.on) \(dateFormatter.string(from: self))"
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return "on \(dateFormatter.string(from: self))"
    }
}

