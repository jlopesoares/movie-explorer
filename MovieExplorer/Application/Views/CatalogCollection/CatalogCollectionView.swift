//
//  CatalogCollectionView.swift
//  MovieExplorer
//
//  Created by João Pedro Soares on 19/07/2023.
//

import UIKit

enum CatalogType {
    case rails,
         grids
}

class CatalogCollectionView: UICollectionView {
    
    var catalogType: CatalogType = .rails {
        didSet {
            collectionViewLayout = createCompositionalLayout()
        }
    }
    
    func updateCatalogType(_ type: CatalogType) {
        catalogType = type
    }
    
    func registerCells() {
        
        register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
        register(ProviderCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProviderCollectionViewCell.self))
        
        register(
            UINib(nibName: CatalogControllerConstants.posterCollectionCell, bundle: .main),
            forCellWithReuseIdentifier: CatalogControllerConstants.posterCollectionCell
        )
   
        register(
            UINib(nibName: "HeaderCollectionReusableView", bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCollectionReausableView"
        )
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            guard .rails == self.catalogType else {
                return self.gridSection()
            }
            
            switch sectionNumber {
                case 0:
                    return self.nowPopularSection()
                case 1:
                    return self.providersSection()
                default:
                    return self.posterSection()
            }
        }
    }
}
