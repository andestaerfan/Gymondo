//
//  MockImageLoader.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine
import UIKit
@testable import Gymondo

final class MockImageLoader: ImageLoader {
    
    var fail = false
    var image: UIImage?
    
    func getImage(for urlString: String) -> AnyPublisher<UIImage?, Error> {
        if fail {
            return Fail(error: NetworkError.decodingFailed)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(image!))
                .eraseToAnyPublisher()
        }
    }
}
