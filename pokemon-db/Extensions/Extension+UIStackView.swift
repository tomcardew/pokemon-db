//
//  Extension+UIStackView.swift
//  pokemon-db
//
//  Created by Admin on 25/06/21.
//

import Foundation
import UIKit

extension UIStackView {
    
    func removeAllItems() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
}
