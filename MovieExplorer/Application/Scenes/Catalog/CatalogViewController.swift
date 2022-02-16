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
            collectionView.register(UINib(nibName: CatalogControllerConstants.posterCollectionCell, bundle: .main),
                                    forCellWithReuseIdentifier: CatalogControllerConstants.posterCollectionCell)
            
            collectionView.register(UINib(nibName: CatalogControllerConstants.detailedCollectionCell, bundle: .main),
                                    forCellWithReuseIdentifier: CatalogControllerConstants.detailedCollectionCell)
            
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        catalogCoordinator.coordinateToDetail()
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
                    
                case 0:
                    return self.nowPopularSection()
                case 1:
                    return self.detailedLayoutSection()
                case 2:
                    return self.thirdLayoutSection()
                default:
                    return self.nowPopularSection()
            }
        }
    }
    
}


extension UIViewController {
    
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(320))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.3), heightDimension: .absolute(320))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        

        if #available(iOS 14.0, *) {
            section.contentInsetsReference = .layoutMargins
        }
        section.interGroupSpacing = .zero
       
      
        return section
        
        
    }
    
    func secondLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
                                                    .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(220),
                                               heightDimension: .absolute(136))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func thirdLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
                                                    .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120),
                                               heightDimension: .absolute(192))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}




//MARK: - Collection Datasource

private enum CatalogControllerConstants {
    static let posterCollectionCell = String(describing: PosterCollectionViewCell.self)
    static let detailedCollectionCell = String(describing: DetailedMovieCollectionViewCell.self)
}




