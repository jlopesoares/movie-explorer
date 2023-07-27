//
//  CatalogViewController.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class CatalogViewController: UIViewController, UICollectionViewDelegate {
    
    // Vars
    weak var catalogCoordinator: DetailCoordinateFlow!
    var viewModel: CatalogViewModel!
    
    // Outlets
    @IBOutlet weak var collectionView: CatalogCollectionView! {
        didSet {
            collectionView.registerCells()
            collectionView.delegate = self
            collectionView.updateCatalogType(.rails)
            collectionDataSource = collectionView.setupCollectionProvider(container: self)
        }
    }
    
    var collectionDataSource: UICollectionViewDiffableDataSource<Rail, AnyHashable>!
   
    // Cocoa
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getCatalogData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getCatalogData() {
        Task { [weak self] in
            await self?.viewModel.getMovies()
            self?.updateCollectionView()
        }
    }
    
    func setupUI() {
        collectionView.backgroundColor = .mainBackgroundColor
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Rail, AnyHashable>()
        snapshot.appendSections(viewModel.datasource)

        for rail in viewModel.datasource {
            snapshot.appendItems(rail.type.values, toSection: rail)
        }

        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

//MARK: - Collection Delegation
extension CatalogViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = viewModel.item(for: indexPath)

        switch item {
        case let item as Movie:
            catalogCoordinator.coordinateToDetail(with: item.movieID)
        case let item as MovieProvider:
            break
        default:
            break
        }
    }
}

//MARK: - Collection Datasource
internal enum CatalogControllerConstants {
    static let posterCollectionCell = String(describing: PosterCollectionViewCell.self)
}
