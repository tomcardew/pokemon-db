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
    static var alertView: AlertBanner = AlertBanner()
    
    public func showLoadingView(message: String = "", parent: UIView? = nil, completion: (() -> Void)? = nil) {
        let loadingView = UIViewController.loadingView
        loadingView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        loadingView.configure(message: message, parentView: parent)
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
    
    func isBeingPresentedInFormSheet() -> Bool {
        if self.traitCollection.horizontalSizeClass == .regular {
            return false
        } else {
            return true
        }
    }
    
    public func showAlert(message: String, isError: Bool = false, autoHide: Bool = true, autoHideDuration: DispatchTime = .now() + 5.0) {
        let insetTop = self.view.safeAreaInsets.top + 5
        let alert = UIViewController.alertView
        alert.frame = CGRect(x: 10, y: -100, width: self.view.bounds.width - 20, height: 100)
        alert.configureView(message: message, isError: isError)
        self.view.addSubview(alert)
        UIView.animate(withDuration: 0.5, animations: {
            alert.frame = CGRect(x: 10, y: insetTop, width: self.view.bounds.width - 20, height: 100)
        }, completion: { result in
            DispatchQueue.main.asyncAfter(deadline: autoHideDuration, execute: {
                self.hideAlert()
            })
        })
    }
    
    public func hideAlert() {
        UIView.animate(withDuration: 0.5, animations: {
            UIViewController.alertView.frame = CGRect(x: 10, y: -100, width: self.view.bounds.width - 20, height: 100)
        }, completion: { result in
            UIViewController.alertView.removeFromSuperview()
        })
    }
    
}
