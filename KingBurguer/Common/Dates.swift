//
//  Dates.swift
//  KingBurguer
//
//  Created by Natã Romão on 22/06/23.
//

import Foundation


extension Date {
    
    func toString(dateFormat: String = "yyyy-MM-dd") -> String {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "en_US_POSIX")
        dt.dateFormat = dateFormat
        return dt.string(from: self)
    }
}
