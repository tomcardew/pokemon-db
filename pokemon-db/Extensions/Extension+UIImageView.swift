//
//  Extension+UIImageView.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func setImageFromUrl(url: String, _ completion: ((UIImage?) -> Void)? = nil) {
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
                            self.image = UIImage(named: "PokeballIcon")
                            self.alpha = 0.25
                        }
                        UIView.animate(withDuration: 1, animations: {
                            self.alpha = 1
                            if let completion = completion {
                                completion(self.image)
                            }
                        })
                    })
                }
            }
        }
    }
    
    public func getImageFromUrl(url: String) -> UIImage? {
        let url = URL(string: url)
        var image: UIImage? = nil
        if let url = url {
            let data = try? Data(contentsOf: url)
            image = UIImage(data: data!)
        }
        return image
    }
    
}
