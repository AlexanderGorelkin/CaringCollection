//
//  CarringCollectionController.swift
//  CaringCollection
//
//  Created by Александр Горелкин on 25.09.2023.
//

import UIKit

final class CaringCollectionController: UIViewController {
    
    static let itemWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    static let itemHeight: CGFloat = UIScreen.main.bounds.height * 0.7
    
    var itemSize = CGSize(width: itemWidth, height: itemHeight)
    
    fileprivate let contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    
    private lazy var collectionFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        return layout
    }()
    
           
           
           
    
    private lazy var carringCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = contentInset
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(carringCollectionView)
        NSLayoutConstraint.activate([
            carringCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            carringCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            carringCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            carringCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
extension CaringCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = carringCollectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.contentView.backgroundColor = .systemGray
        cell.contentView.layer.cornerRadius = 20
        return cell
    }
    
    
}
extension CaringCollectionController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = carringCollectionView.indexPathForItem(at: visiblePoint) else { return }
        carringCollectionView.scrollToItem(at: visibleIndexPath, at: .left, animated: true)
    }
    
}
