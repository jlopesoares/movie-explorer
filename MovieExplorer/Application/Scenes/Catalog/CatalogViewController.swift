//
//  CatalogViewController.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class CatalogViewController: UIViewController, UICollectionViewDelegate {

    //Coordinator
    weak var catalogCoordinator: DetailCoordinateFlow!

    var viewModel: CatalogViewModel!
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            registerCells()
            collectionView.delegate = self
            collectionView.collectionViewLayout = createCompositionalLayout()
        }
    }
    
    var collectionDataSource: UICollectionViewDiffableDataSource<Rail, AnyHashable>!
   
    //Cocoa
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionProvider()
      
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

//MARK: - CollectionDataSource
extension CatalogViewController {
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            switch indexPath.section {
            case 0:
                let simpleMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogControllerConstants.posterCollectionCell, for: indexPath) as! PosterCollectionViewCell
//                simpleMovieCell.setup(movie: movie)
                
                if let movie = movie as? Movie {
                    print(movie)
                    simpleMovieCell.setup(movie: movie)
                }
                
                
                return simpleMovieCell
                
            case 1:
                let movieProviderCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProviderCollectionViewCell.self), for: indexPath) as! ProviderCollectionViewCell
                
                if let provider = movie as? MovieProvider {
                    print("\(indexPath.row) - \(provider)")
                    movieProviderCell.embed(in: self, with: provider)
                }
                
                return movieProviderCell
                
            default:
                let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
  
                if let movie = movie as? Movie {
                    print(movie)
                    movieCell.embed(in: self, with: movie)
                }
                
                return movieCell
            }
        })
        
        collectionDataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView in
        
            if kind == UICollectionView.elementKindSectionHeader {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollectionReausableView", for: indexPath) as! HeaderCollectionReusableView
                header.titleLabel.text = self.viewModel.datasource[indexPath.section].name
                header.headerButton.setTitle("Ver todos", for: .normal)
                return header
            }
            
            return UICollectionReusableView()
        }
    }
}

//MARK: - Collection Delegation
extension CatalogViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch viewModel.datasource[indexPath.section].type {
        case .providers(let providers):
            break
        case .movies(let movies):
            catalogCoordinator.coordinateToDetail(with: movies[indexPath.row].id)
        }
        
//        catalogCoordinator.coordinateToDetail(with:viewModel.datasource[indexPath.section].type.values[indexPath.row])
    }
}

//MARK: - Collection Datasource
internal enum CatalogControllerConstants {
    static let posterCollectionCell = String(describing: PosterCollectionViewCell.self)
    static let detailedCollectionCell = String(describing: DetailedMovieCollectionViewCell.self)
}
