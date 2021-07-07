//
//  AppStoryboard.swift
//  pokemon-db
//
//  Created by Admin on 25/06/21.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    
    case Main
    case NewsDetails
    case WebView
    case Pokedex
    case PokemonDetails
    case Abilities
    case AllAbilities

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
