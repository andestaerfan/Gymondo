//
//  ExerciseDetailUseCase.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine

final class MainExerciseDetailUseCase: ExerciseDetailUseCase {
    
    private let apiRequester: APIRequest
    private var request: NetworkRequestModel
    
    init(apiRequester: APIRequest = APIRequestClient(),
         request: NetworkRequestModel) {
        self.apiRequester = apiRequester
        self.request = request
    }
    
    func getExerciseDetail(for id: Int) -> AnyPublisher<ExerciseDetail, Error> {
        request.path = AppConstants.APIConstants.exerciseInfoPath + "/\(id)"
        return apiRequester.request(with: request)
    }
}
