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
    
    private let presenter = MainPresenter(service: NewsService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUi()
        
        presenter.setViewDelegate(viewDelegate: self)
        presenter.loadFeaturedNews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(handleOpenPokedex))
        btn1.addGestureRecognizer(gesture1)
        
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
        self.newsStackView.removeAllItems()
        guard let articles = list.articles else {
            loadingIndicator.stopAnimating()
            return
        }
        for article in articles {
            let n = News()
            n.height(constant: 100)
            n.initializeView(data: article)
            n.alpha = 0
            let touchEvent = ArticleGestureRecognizer(target: self, action: #selector(handleNewsTap(sender:)))
            touchEvent.articleSelected = article
            n.addGestureRecognizer(touchEvent)
            newsStackView.addArrangedSubview(n)
            UIView.animate(withDuration: 1, animations: {
                n.alpha = 1
            })
        }
        loadingIndicator.stopAnimating()
        scrollViewHeight.constant = 2050
    }
    
    @objc func handleNewsTap(sender: ArticleGestureRecognizer) {
        let storyboard = AppStoryboard.NewsDetails
        let vc = NewsDetailsViewController.instantiate(fromAppStoryboard: storyboard)
        vc.article = sender.articleSelected
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleOpenPokedex() {
        let storyboard = AppStoryboard.Pokedex
        let vc = PokedexViewController.instantiate(fromAppStoryboard: storyboard)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension MainViewController: MainDelegate {
    
    func loadedFeaturedNews(news: NewsModel) {
        self.loadNews(list: news)
    }
    
    func onError(errorMessage: String) {
        print("ERROR: \(errorMessage)")
        let errorView = ErrorView()
        errorView.initializeView(message: errorMessage, isDark: false)
        errorView.delegate = self
        self.newsStackView.addArrangedSubview(errorView)
        scrollViewHeight.constant = self.view.bounds.height
    }
    
}

extension MainViewController: ErrorViewDelegate {
    
    func onRetryPress() {
        self.newsStackView.removeAllItems()
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        self.presenter.loadFeaturedNews()
    }
    
}

class ArticleGestureRecognizer: UITapGestureRecognizer {
    
    var articleSelected: Article?
    
}
