//
//  ExercisesListUseCase.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine

final class MainExercisesListUseCase: ExercisesListUseCase {
    
    private let apiRequester: APIRequest
    private var request: NetworkRequestModel
    
    init(apiRequester: APIRequest = APIRequestClient(), request: NetworkRequestModel) {
        self.apiRequester = apiRequester
        self.request = request
    }
    
    func getExercises() -> AnyPublisher<Exercises, Error> {
        request.path = AppConstants.APIConstants.exercises
        return apiRequester.request(with: request)
            .share()
            .eraseToAnyPublisher()
    }
}
extension MainExercisesListUseCase: ExercisesImageUseCase {
    func getExerciseImage(with id: Int) -> AnyPublisher<String?, Error> {
        request.path = AppConstants.APIConstants.exerciseImageUrlPath + "/\(id)"
        let exerciseImage: AnyPublisher<ExerciseImage, Error> = apiRequester.request(with: request)
        return exerciseImage
            .map(\.image)
            .share()
            .eraseToAnyPublisher()
        
    }
}
