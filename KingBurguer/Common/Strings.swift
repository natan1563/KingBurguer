//
//  Strings.swift
//  KingBurguer
//
//  Created by Natã Romão on 18/03/23.
//

import Foundation


extension String {
    
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func charAtIndex(index: Int) -> Character? {
        var indexCurrent = 0
        for char in self {
            if index == indexCurrent {
                return char
            }
            indexCurrent = indexCurrent + 1
        }
        return nil
    }
    
    func toDate(dateFormat: String = "dd/MM/yyyy") -> Date? {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "en_US_POSIX")
        dt.dateFormat = dateFormat
        
        return dt.date(from: self)
    }
    
}
