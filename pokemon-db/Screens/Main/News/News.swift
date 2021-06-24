//
//  News.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import UIKit

class News: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("News", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.layer.cornerRadius = 10
    }
    
    public func initializeView(data: Article) {
        imageView.setImageFromUrl(url: data.urlToImage ?? "")
        titleLabel.text = data.title
        dateLabel.text = Date().stringDate(utcDate: data.publishedAt)
    }

}
