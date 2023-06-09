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
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            registerCells()
            collectionView.delegate = self
            collectionView.collectionViewLayout = createCompositionalLayout()
        }
    }
    
    var collectionDataSource: UICollectionViewDiffableDataSource<Rail, AnyHashable>!
   
    // Cocoa
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionProvider()
        getCatalogData()
        
    }
    
    func getCatalogData() {
        Task { [weak self] in
            await self?.viewModel.getMovies()
            self?.updateCollectionView()
        }
    }
    
    func setupUI() {
        collectionView.backgroundColor = UIColor(named: "mainBackgroundColor")
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
            catalogCoordinator.coordinateToDetail(with: item.id)
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
