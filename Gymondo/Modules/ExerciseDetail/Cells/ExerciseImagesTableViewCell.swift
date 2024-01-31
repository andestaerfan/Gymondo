//
//  ExerciseImagesTableViewCell.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import UIKit

final class ExerciseImagesTableViewCell: UITableViewCell {
    
    private(set) lazy var collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    private func setupView() {
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingConstraint = collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let topConstraint = collectionView.topAnchor.constraint(equalTo: topAnchor)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))
    }
}
extension ExerciseImagesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 100)
    }
}

