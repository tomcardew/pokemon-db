//
//  Extension+String.swift
//  pokemon-db
//
//  Created by Admin on 01/07/21.
//

import Foundation

extension String {
    
    func removeInnecesaryCharacters() -> String {
        var tmp = self.replacingOccurrences(of: "\n", with: " ")
        tmp = tmp.replacingOccurrences(of: "\u{000C}", with: " ")
        return tmp
    }
    
}
