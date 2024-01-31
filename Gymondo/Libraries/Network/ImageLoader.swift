//
//  ImageLoader.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine
import UIKit

protocol ImageLoader {
    func getImage(for urlString: String) -> AnyPublisher<UIImage?, Error>
}
enum ImageLoaderError: Error {
    case invalidUrl
}
final class ImageLoaderClient: ImageLoader {
    
    private let dataRequest: HTTPDataRequest
    private var images: [String: UIImage?] = [:]
    
    init(dataRequest: HTTPDataRequest) {
        self.dataRequest = dataRequest
    }
    
    func getImage(for urlString: String) -> AnyPublisher<UIImage?, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: ImageLoaderError.invalidUrl)
                .eraseToAnyPublisher()
        }
        if let image = images[urlString] {
            return Result.Publisher(.success(image))
                .eraseToAnyPublisher()
        }
        let pub = dataRequest
            .request(with: URLRequest(url: url))
            .map { [weak self] in
                let image = UIImage(data: $0)
                self?.images[urlString] = image
                return image
            }
            .share()
            .eraseToAnyPublisher()
        
        return pub
    }
}
