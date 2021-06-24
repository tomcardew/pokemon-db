//
//  Extension+UIImageView.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func setImageFromUrl(url: String) {
        let url = URL(string: url)
        if let url = url {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1, animations: {
                        self.alpha = 0
                    }, completion: { result in
                        if let data = data {
                            self.image = UIImage(data: data)
                        } else {
                            self.image = UIImage(named: "NoImageFound")
                        }
                        UIView.animate(withDuration: 1, animations: {
                            self.alpha = 1
                        })
                    })
                }
            }
        }
    }
    
}
