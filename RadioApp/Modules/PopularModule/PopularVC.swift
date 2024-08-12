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
    private let realmService = AppDIContainer().realm
    private var isLoadingMoreData = false
    private var currentPage = 20
    private var selectedIndexPath: IndexPath?
    
    var player: PlayerView?
    
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
        currentPage > 20 ? popularView.spinnerPagination.startAnimating() : popularView.spinner.startAnimating()
        isLoadingMoreData = true
        networkService.fetchData(from: Link.popular(count: currentPage).url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                stations = success
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    popularView.collectionView.reloadData()
                    popularView.spinner.stopAnimating()
                    popularView.spinnerPagination.stopAnimating()
                }
                isLoadingMoreData = false
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
        let isFavorite = realmService.isFavorite(withID: station.stationuuid, stations: Array(realmService.fetchStations()))
        
        cell.configureCell(station, isFavorite)
        cell.handlerSaveRealm = { [weak self] isSave in
            guard let self else { return }
            if isSave {
                realmService.save(station)
            }
        }
        
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
        if let url = URL(string: stations[indexPath.item].url) {
            player?.setStationURL(url)
            player?.play()
        }
        if selectedIndexPath == indexPath {
            let vc = StationDetailsVC()
            vc.radioLabel.text = stations[indexPath.item].tags
            vc.stationLabel.text = stations[indexPath.item].name
            navigationController?.pushViewController(vc, animated: true)

            self.selectedIndexPath = nil
        }
        selectedIndexPath = indexPath
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if !isLoadingMoreData {
                fetchPopularStations()
                currentPage += 20
            }
        }
    }
}

