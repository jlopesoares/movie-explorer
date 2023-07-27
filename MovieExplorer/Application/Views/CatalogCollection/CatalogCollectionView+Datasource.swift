//
//  CatalogCollectionView+Datasource.swift
//  MovieExplorer
//
//  Created by João Pedro Soares on 22/07/2023.
//

import UIKit

//MARK: - CollectionDataSource
extension CatalogCollectionView {
    
    func setupCollectionProvider(container: UIViewController) -> UICollectionViewDiffableDataSource<Rail, AnyHashable> {

        let collectionDatasource: UICollectionViewDiffableDataSource<Rail, AnyHashable> = UICollectionViewDiffableDataSource(collectionView: self, cellProvider: { collectionView, indexPath, item in
            
            switch item {
            case let provider as MovieProvider:
                
                let movieProviderCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProviderCollectionViewCell.self), for: indexPath) as! ProviderCollectionViewCell
                movieProviderCell.embed(in: container, with: provider)
                
                return movieProviderCell
            default:
                let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
                movieCell.embed(in: container, with: item as! Movie)
                
                return movieCell
            }
        })
        
        collectionDatasource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView in
        
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollectionReausableView", for: indexPath) as! HeaderCollectionReusableView
//                header.setup(with: self.viewModel.rail(for: indexPath))
                return header
            }
            
            return UICollectionReusableView()
        }
        
        return collectionDatasource
    }
}
