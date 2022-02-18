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
    
    var collectionDataSource: UICollectionViewDiffableDataSource<Rail, Movie>!
   
    //Cocoa
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, model in
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogControllerConstants.posterCollectionCell, for: indexPath) as? PosterCollectionViewCell,
               indexPath.section == 0 {
                cell.setup(movie: model)
                return cell
            }
            
            if let detailedMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogControllerConstants.detailedCollectionCell, for: indexPath) as? DetailedMovieCollectionViewCell,
               indexPath.section > 0 {
                detailedMovieCell.setup(movie: model)
                return detailedMovieCell
            }
            
            return .none
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
      
        viewModel.getMovies { [weak self] in
            self?.updateCollectionView()
        }
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Rail, Movie>()
        snapshot.appendSections(viewModel.datasource)

        
        for rail in viewModel.datasource {
            snapshot.appendItems(rail.movies, toSection: rail)
        }

        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
   
  
}

//MARK: - CollectionDataSource
extension CatalogViewController {
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            var collectionViewCell: UICollectionViewCell
            
            switch indexPath.section {
                case 1:
                    let detailedCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogControllerConstants.detailedCollectionCell, for: indexPath) as! DetailedMovieCollectionViewCell
                    detailedCell.setup(movie: movie)
                    
                    collectionViewCell = detailedCell
                default:
                    
                    let simpleMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogControllerConstants.posterCollectionCell, for: indexPath) as! PosterCollectionViewCell
                    simpleMovieCell.setup(movie: movie)
                    
                    collectionViewCell = simpleMovieCell
            }
            
            return collectionViewCell
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
        catalogCoordinator.coordinateToDetail()
    }
}

//MARK: - Collection Datasource
internal enum CatalogControllerConstants {
    static let posterCollectionCell = String(describing: PosterCollectionViewCell.self)
    static let detailedCollectionCell = String(describing: DetailedMovieCollectionViewCell.self)
}
