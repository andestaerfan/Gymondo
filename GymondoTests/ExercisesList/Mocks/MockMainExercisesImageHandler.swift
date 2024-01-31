//
//  MockMainExercisesImageHandler.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 31.01.24.
//

import Foundation
import Combine
import UIKit
@testable import Gymondo

final class MockMainExercisesImageHandler: ExercisesImageHandler {
    
    var count = 0
    var fail = false
    var image: UIImage!
    
    func getExerciseImage(for id: Int) -> AnyPublisher<UIImage?, Error> {
        count += 1
        if fail {
            return Fail(error: NetworkError.decodingFailed)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(image!)).eraseToAnyPublisher()
        }
    }
    
    
}
