//
//  MockExercisesListUseCase.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine
@testable import Gymondo

final class MockExercisesListUseCase: ExercisesListUseCase, ExercisesImageUseCase {
    
    var fail = false
    var exercises: Exercises!
    var imageString: String!
    
    func getExercises() -> AnyPublisher<Exercises, Error> {
        if fail {
            return Fail(error: NetworkError.decodingFailed)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(exercises!)).eraseToAnyPublisher()
        }
    }
    
    func getExerciseImage(with id: Int) -> AnyPublisher<String?, Error> {
        if fail {
            return Fail(error: NetworkError.decodingFailed)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(imageString!))
                .eraseToAnyPublisher()
        }
    }
}
