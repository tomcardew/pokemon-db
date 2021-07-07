//
//  AllAbilitiesViewController.swift
//  pokemon-db
//
//  Created by Admin on 07/07/21.
//

import UIKit

class AllAbilitiesViewController: UIViewController {
    
    var viewModel: AllAbilitiesViewModel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }
    
    private func initView() {
        self.view.clipsToBounds = true
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib.init(nibName: AbilityCellItem.identifier, bundle: nil), forCellWithReuseIdentifier: AbilityCellItem.identifier)
    }
    
    private func initViewModel() {
        viewModel = AllAbilitiesViewModel(service: PokemonService.shared)
        
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let loading = self?.viewModel.isLoading else { return }
            if loading {
                self?.showLoadingView(message: "Loading abilities", parent: nil, completion: nil)
            } else {
                self?.hideLoadingView()
            }
        }
        
        viewModel.reloadCollectionView = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.initFetch()
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AllAbilitiesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentList.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AbilityCellItem.identifier, for: indexPath) as! AbilityCellItem
        let element = viewModel.currentList.results![indexPath.row]
        cell.setTitle(element.name.capitalized)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width / 3, height: 60)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.reloadData(data: AbilityList(count: 0, next: nil, previous: nil, results: [DefaultItem]()))
    }
    
}
