//
//  Extension+UIViewController.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var loadingView: LoadingView = LoadingView()
    
    public func showLoadingView(message: String = "", completion: (() -> Void)? = nil) {
        let loadingView = UIViewController.loadingView
        loadingView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        loadingView.configure(message: message)
        loadingView.alpha = 0
        self.view.addSubview(loadingView)
        UIView.animate(withDuration: 0.5, animations: {
            loadingView.alpha = 1
            if let completion = completion {
                completion()
            }
        })
    }
    
    public func hideLoadingView(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            UIViewController.loadingView.alpha = 0
        }, completion: { result in
            UIViewController.loadingView.removeFromSuperview()
            if let completion = completion {
                completion()
            }
        })
    }
    
}
