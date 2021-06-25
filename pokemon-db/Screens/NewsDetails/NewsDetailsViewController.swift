//
//  NewsDetailsViewController.swift
//  pokemon-db
//
//  Created by Admin on 25/06/21.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var backButtonBlurView: UIVisualEffectView!
    @IBOutlet weak var backButtonContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentPaddingTop: NSLayoutConstraint!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = article!.title
        imageView.setImageFromUrl(url: article!.urlToImage ?? "")
    }
    
    override func viewDidLayoutSubviews() {
        contentPaddingTop.constant = view.safeAreaInsets.top * -1
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
