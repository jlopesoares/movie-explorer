//
//  CatalogViewController+UIFactory.swift
//  MovieExplorer
//
//  Created by João Pedro on 18/02/2022.
//

import UIKit

//MARK: - Register
extension CatalogViewController {
    
    func registerCells() {
        
        collectionView.register(
            UINib(nibName: CatalogControllerConstants.posterCollectionCell, bundle: .main),
            forCellWithReuseIdentifier: CatalogControllerConstants.posterCollectionCell
        )
        
        collectionView.register(
            UINib(nibName: CatalogControllerConstants.detailedCollectionCell, bundle: .main),
            forCellWithReuseIdentifier: CatalogControllerConstants.detailedCollectionCell
        )
        
        collectionView.register(
            UINib(nibName: "HeaderCollectionReusableView", bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCollectionReausableView"
        )
    }
}

//MARK: - Supplementary Views
extension CatalogViewController {
    
    func detailedSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}


//MARK: - CollectionViewLayouts
extension CatalogViewController {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
                case 0:
                    return self.nowPopularSection()
                case 1:
                    return self.detailedLayoutSection()
                default:
                    return self.detailedLayoutSection()
            }
        }
    }
    
    func nowPopularSection() -> NSCollectionLayoutSection {
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98),
                                               heightDimension: .absolute(420.0))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        

        if #available(iOS 14.0, *) {
            section.contentInsetsReference = .layoutMargins
        }
        
        section.interGroupSpacing = .zero
        return section
    }
    
    func detailedLayoutSection() -> NSCollectionLayoutSection {
        
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.3), heightDimension: .absolute(250))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        

        if #available(iOS 14.0, *) {
            section.contentInsetsReference = .layoutMargins
        }
        
        section.interGroupSpacing = .zero
        section.boundarySupplementaryItems = [detailedSectionHeader()]
      
        return section
    }
}
