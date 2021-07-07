//
//  PokedexViewController.swift
//  pokemon-db
//
//  Created by Admin on 27/06/21.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var backBtnContainer: UIVisualEffectView!
    @IBOutlet weak var searchBtnContainer: UIVisualEffectView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter = PokedexPresenter(service: PokemonService.shared)
    
    private static let searchBar = FloatingSearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUi()
        
        presenter.setViewDelegate(viewDelegate: self)
        presenter.loadList()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib.init(nibName: "PokemonItemCell", bundle: nil), forCellWithReuseIdentifier: "PokemonItemCell")
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    private func setupUi() {
        backBtnContainer.layer.cornerRadius = 15
        backBtnContainer.clipsToBounds = true
        searchBtnContainer.layer.cornerRadius = 15
        searchBtnContainer.clipsToBounds = true
        self.view.clipsToBounds = true
    }
    
    private func filterElementsBy(name: String) {
        if !name.isEmpty {
            let data = PokemonService.shared.previousResults?.results?.filter { item in
//                item.name.range(of: name, options: .caseInsensitive) != nil
                return item.name.lowercased().starts(with: name.lowercased())
            }
            PokemonService.shared.filteredResults = PokemonList(count: data?.count ?? 0, next: PokemonService.shared.previousResults?.next, previous: PokemonService.shared.previousResults?.previous, results: data)
        } else {
            PokemonService.shared.filteredResults = PokemonService.shared.previousResults
        }
        UIView.animate(withDuration: 1, animations: {
            self.collectionView.reloadData()
        })
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        let view = PokedexViewController.searchBar
        view.configureView(placeholder: "Search by name")
        view.setViewDelegate(delegate: self)
        view.showView(parent: self.view, finalFrame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
    }
    
}

extension PokedexViewController: PokedexDelegate {
    
    func didReceiveError(error: String) {
        debugPrint(error)
    }
    
    func listDidLoad(list: PokemonList) {
        collectionView.reloadData()
    }
    
}

extension PokedexViewController: FloatingSearchBarDelegate {
    func willClose() {
        PokemonService.shared.filteredResults = PokemonService.shared.previousResults
        self.collectionView.reloadData()
        PokedexViewController.searchBar.hideView(parent: self.view)
    }
    
    func didChangeValue(value: String) {
        self.filterElementsBy(name: value)
    }
}

extension PokedexViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokemonService.shared.filteredResults?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonItemCell", for: indexPath) as! PokemonItemCell
        cell.layer.cornerRadius = 10
        cell.configure(from: PokemonService.shared.filteredResults!.results![indexPath.row])
        return cell
    }
    
}

extension PokedexViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = AppStoryboard.PokemonDetails
        let vc = PokemonDetailsViewController.instantiate(fromAppStoryboard: storyboard)
        vc.data = PokemonService.shared.filteredResults!.results![indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if view.frame.width > 800 {
            return CGSize(width: (view.frame.width/4) - 15, height: 120)
        } else if view.frame.width > 500 {
            return CGSize(width: (view.frame.width/3) - 15, height: 120)
        }
        return CGSize(width: (view.frame.width/2) - 15, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

extension PokedexViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
