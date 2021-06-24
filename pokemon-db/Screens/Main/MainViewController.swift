//
//  MainViewController.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationStackView: UIStackView!
    @IBOutlet weak var newsStackView: UIStackView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUi()
        
        NetworkRequests.shared.getFeaturedNews(onSuccess: { result in
            self.loadNews(list: result)
        })
    }
    
    private func setupUi() {
        setupNavigationButtons()
    }
    
    private func setupNavigationButtons() {
        var horizontalStackViews = [UIStackView]()
        
        let st1 = UIStackView()
        st1.axis = .horizontal
        st1.distribution = .fillEqually
        st1.alignment = .top
        st1.spacing = 10
        horizontalStackViews.append(st1)
        
        let st2 = UIStackView()
        st2.axis = .horizontal
        st2.distribution = .fillEqually
        st2.alignment = .top
        st2.spacing = 10
        horizontalStackViews.append(st2)
        
        var buttons = [HomescreenButton]()
        
        let btn1 = HomescreenButton()
        btn1.initializeButton(label: "Pokedex", color: UIColor.pokeGreen())
        btn1.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 55)
        
        let btn2 = HomescreenButton()
        btn2.initializeButton(label: "Moves", color: UIColor.pokeRed())
        btn2.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 55)
        
        let btn3 = HomescreenButton()
        btn3.initializeButton(label: "Abilities", color: UIColor.pokeYellow())
        btn3.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 55)
        
        let btn4 = HomescreenButton()
        btn4.initializeButton(label: "Games", color: UIColor.pokeBlue())
        btn4.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 55)
        
        buttons.append(btn1)
        buttons.append(btn2)
        buttons.append(btn3)
        buttons.append(btn4)
        
        for (index, btn) in buttons.enumerated() {
            horizontalStackViews[index%2].addArrangedSubview(btn)
        }
        
        for st in horizontalStackViews {
            navigationStackView.addArrangedSubview(st)
        }
    }
    
    private func loadNews(list: NewsModel) {
        for article in list.articles {
            let n = News()
            n.height(constant: 100)
            n.initializeView(data: article)
            n.alpha = 0
            newsStackView.addArrangedSubview(n)
            UIView.animate(withDuration: 1, animations: {
                n.alpha = 1
            })
        }
        loadingIndicator.stopAnimating()
        scrollViewHeight.constant = 2050
    }

}
