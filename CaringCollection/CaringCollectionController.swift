//
//  CaringCollectionController.swift
//  CaringCollection
//
//  Created by Александр Горелкин on 25.09.2023.
//

import UIKit


final class CaringCollectionController: UIViewController {
    
    private static let itemSize: CGSize = .init(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.7)
    private static let itemSpacing: CGFloat = 16
    
    // MARK: - Views
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = Self.itemSize
        layout.minimumLineSpacing = Self.itemSpacing
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        view.showsHorizontalScrollIndicator = false
        
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        collectionViewLayout.sectionInset.left = collectionView.layoutMargins.left
    }
     
}
extension CaringCollectionController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        cell.contentView.backgroundColor = .lightGray
        cell.contentView.layer.cornerRadius = 12
        
        return cell
    }
}

extension CaringCollectionController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let itemWidth = Self.itemSize.width + Self.itemSpacing
        let contentOffset = targetContentOffset.pointee.x + Self.itemSpacing
        let itemToScroll = round(contentOffset / itemWidth)
        
        targetContentOffset.pointee = CGPoint(x: itemToScroll * itemWidth - scrollView.contentInset.left,
                                              y: scrollView.contentInset.top)
    }
    
}


