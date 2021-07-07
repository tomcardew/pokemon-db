//
//  Extension+UIColor.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import Foundation
import UIKit

extension UIColor {
    
    class func pokeGreen() -> UIColor {
        return #colorLiteral(red: 0.31, green: 0.76, blue: 0.65, alpha: 1.00)
    }
    
    class func pokeRed() -> UIColor {
        return #colorLiteral(red: 0.95, green: 0.47, blue: 0.42, alpha: 1.00)
    }
    
    class func pokeBlue() -> UIColor {
        return #colorLiteral(red: 0.34, green: 0.67, blue: 0.96, alpha: 1.00)
    }
    
    class func pokeYellow() -> UIColor {
        return #colorLiteral(red: 0.97, green: 0.81, blue: 0.29, alpha: 1.00)
    }
    
    /**
     Check if the color is light or dark, as defined by the injected lightness threshold.
     - Parameter threshold: Some people report that 0.7 is best. I suggest to find out for yourself.
     - Returns: A nil value is returned if the lightness couldn't be determined.
     */
    func isLight(threshold: Float = 0.5) -> Bool? {
        let originalCGColor = self.cgColor
        
        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return nil
        }
        guard components.count >= 3 else {
            return nil
        }
        
        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }
    
    /**
     Generates a random color
     - Returns: The UIColor object with the generated random color
     */
    static func random() -> UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
    
}
