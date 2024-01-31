//
//  MockExerciseDetailUseCase.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine
@testable import Gymondo

final class MockExerciseDetailUseCase: ExerciseDetailUseCase {
    
    var fail = false
    var exerciseDetail: ExerciseDetail!
    
    func getExerciseDetail(for id: Int) -> AnyPublisher<ExerciseDetail, Error> {
        if fail {
            return Fail(error: NetworkError.decodingFailed)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(exerciseDetail!))
                .eraseToAnyPublisher()
        }
    }
}
