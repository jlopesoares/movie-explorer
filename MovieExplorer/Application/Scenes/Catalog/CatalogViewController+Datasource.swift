//
//  CatalogViewController+Datasource.swift
//  MovieExplorer
//
//  Created by João Pedro on 10/06/2023.
//

import UIKit

//MARK: - CollectionDataSource
extension CatalogViewController {
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            let item = self.viewModel.item(for: indexPath)
            
            switch indexPath.section {
            case 0:
                let simpleMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogControllerConstants.posterCollectionCell, for: indexPath) as! PosterCollectionViewCell
                
                if let movie = item as? Movie {
                    simpleMovieCell.setup(movie: movie)
                }
                
                return simpleMovieCell
                
            case 1:
                let movieProviderCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProviderCollectionViewCell.self), for: indexPath) as! ProviderCollectionViewCell
                
                if let provider = item as? MovieProvider {
                    movieProviderCell.embed(in: self, with: provider)
                }
                
                return movieProviderCell
                
            default:
                let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
  
                if let movie = item as? Movie {
                    movieCell.embed(in: self, with: movie)
                }
                
                return movieCell
            }
        })
        
        collectionDataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView in
        
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollectionReausableView", for: indexPath) as! HeaderCollectionReusableView
                header.setup(with: self.viewModel.rail(for: indexPath))
                return header
            }
            
            return UICollectionReusableView()
        }
    }
}
