//
//  ViewController.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Artist>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Artist>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    private var artists: [Artist] = Bundle.main.decode(
        [Artist].self, from: "artists.json"
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        setupCollectionView()
        createDataSource()
        
        dataSource?.apply(createSnapshot())
    }

    // MARK: - Private methods
    
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(
            ArtistCell.self,
            forCellWithReuseIdentifier: ArtistCell.reuseIdentifier
        )
        
        view.addSubview(collectionView)
    }
    
    // MARK: CollectionView Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / 2)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: CollectionView DataSource
    
    private func createDataSource() {
        dataSource = DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, artist in
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ArtistCell.reuseIdentifier,
                    for: indexPath
                  ) as? ArtistCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: artist)

            return cell
        }
    }
    
    private func createSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([1])
        snapshot.appendItems(artists)
        return snapshot
    }
    
    private func delete(at index: Int) {
        makeSnapshot(animated: true)
    }
    
    private func makeSnapshot(animated: Bool = true) {
//        var snapshot = dataSource.snapshot()
//        let difference = colorModels.difference(from: snapshot.itemIdentifiers)
//        let currentIdentifiers = snapshot.itemIdentifiers
//        
//        guard let newIdentifiers = currentIdentifiers.applying(difference) else {
//            return
//        }
//        snapshot.deleteItems(currentIdentifiers)
//        snapshot.appendItems(newIdentifiers)
//        
//        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        //
    }
}
