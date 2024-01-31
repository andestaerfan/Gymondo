//
//  ExerciseImagesDataSource.swift
//  Gymondo
//
//  Created by Erfan Andesta on 28.01.24.
//

import Foundation
import UIKit
import Combine

protocol ExerciseImagesDataSourceProtocol: UICollectionViewDataSource {
    var images: [AnyPublisher<UIImage?, Error>] { get set }
}
final class ExerciseImagesDataSource: NSObject, ExerciseImagesDataSourceProtocol {
    
    var images = [AnyPublisher<UIImage?, Error>]()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bind(publisher: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}
