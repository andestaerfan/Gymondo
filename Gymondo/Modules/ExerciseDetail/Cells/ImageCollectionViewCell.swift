//
//  ImageCollectionViewCell.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import UIKit
import Combine

final class ImageCollectionViewCell: UICollectionViewCell {
    
    private(set) var imageView = UIImageView()
    private(set) var cancellable: AnyCancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingConstraint = imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let topConstraint = imageView.topAnchor.constraint(equalTo: topAnchor)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
extension ImageCollectionViewCell {
    func bind(publisher: AnyPublisher<UIImage?, Error>) {
        cancellable?.cancel()
        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] image in
                self?.imageView.image = image
            }
    }
}
