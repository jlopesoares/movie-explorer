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
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
        collectionView.register(ProviderCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProviderCollectionViewCell.self))
        
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
                    return self.providersSection()
                default:
                    return self.posterSection()
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
                                               heightDimension: .absolute(230.0))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: 24, bottom: .zero, trailing: .zero)
        section.contentInsetsReference = .layoutMargins
        section.interGroupSpacing = .zero
        return section
    }
    
    func posterSection() -> NSCollectionLayoutSection {
        
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1.0))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(241),
                                               heightDimension: .absolute(237))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.interItemSpacing = .fixed(24)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 32.0)
        section.contentInsetsReference = .layoutMargins
        section.interGroupSpacing = 24
        section.boundarySupplementaryItems = [detailedSectionHeader()]
      
        return section
    }
    
    func providersSection() -> NSCollectionLayoutSection {
        
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1.0))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(131),
                                               heightDimension: .absolute(61))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.interItemSpacing = .fixed(8)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 32.0)
        section.contentInsetsReference = .layoutMargins
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems = [detailedSectionHeader()]
      
        return section
    }
}
