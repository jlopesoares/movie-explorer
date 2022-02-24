//
//  DetailsViewController.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    weak var coordinator: DetailsCoordinator!
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = createDetailsCompositionalLayout()
        }
    }
    var collectionDataSource: UICollectionViewDiffableDataSource<DetailSections, Movie.Diffable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionProvider()
        getMovieDetail()
    }
    
    func getMovieDetail() {

        viewModel.fetchMovieDetails { result in
            switch result {
                case .success(_):
                    self.updateCollectionView()
                case .failure(_):
                    break
            }
        }
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<DetailSections, Movie.Diffable>()
        snapshot.appendSections([DetailSections.header])
        snapshot.appendItems([Movie.Diffable(movie: self.viewModel.movie!)], toSection: DetailSections.header)

        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            var collectionViewCell: UICollectionViewCell
            
            switch indexPath.section {
                case 0:
                    let detailedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailHeaderCell", for: indexPath) as! DetailHeaderCollectionViewCell
                    detailedCell.setup(movie: movie)
                    
                    collectionViewCell = detailedCell
                    
                default:
                    
                    let detailedCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogControllerConstants.detailedCollectionCell, for: indexPath) as! DetailedMovieCollectionViewCell
                    
                    detailedCell.setup(movie: movie)
                    
                    collectionViewCell = detailedCell
            }
            
            return collectionViewCell
        })
    }
    
    func createDetailsCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
                case 0:
                    return self.nowPopularSection()
                default:
                    return self.nowPopularSection()
            }
        }
    }
    
    func nowPopularSection() -> NSCollectionLayoutSection {
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.7))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = .zero
        return section
    }
    
}
