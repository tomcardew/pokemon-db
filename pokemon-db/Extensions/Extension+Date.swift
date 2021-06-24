//
//  Extension+Date.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import Foundation

extension Date {
    
    /**
     Returns a string in format dd-MM-yyyy HH:mm from a string with format yyyy-MM-dd'T'HH:mm:ss.SSSZ by translating it into Date and then into string again
     
     - Parameters:
        - utcDate: The string date to translate
     - Returns: The date string with the new format
     */
    public func stringDate(utcDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: utcDate)
        let outputFormat = DateFormatter()
        outputFormat.dateFormat = "dd/MM/yyyy HH:mm"
        return outputFormat.string(from: date ?? Date())
    }
    
}
