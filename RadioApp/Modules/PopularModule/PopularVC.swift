//
//  PopularsVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit

final class PopularVC: UIViewController {
    
    // MARK: - Private properties
    private let popularView = PopularView()
    private var stations: [Station] = []
    private let networkService = NetworkService.shared
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        popularView.setDelegates(self)
        fetchPopularStations()
    }
    
    // MARK: - Private methods
    private func fetchPopularStations() {
        networkService.fetchData(from: Link.popular.url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                stations = success
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    popularView.collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension PopularVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.description(), for: indexPath) as? PopularCell else {
            return UICollectionViewCell()
        }
        
        let station = stations[indexPath.item]
        cell.configureCell(station)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PopularVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 15.0
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing
        let itemSize = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
