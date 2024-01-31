//
//  MockAPIRequest.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine
@testable import Gymondo

final class MockAPIRequest: APIRequest {
    
    var fail = false
    var model: Decodable?
    var request: NetworkRequestModel?
    
    func request<T>(with request: NetworkRequestModel) -> AnyPublisher<T, Error> where T : Decodable {
        self.request = request
        if fail {
            return Fail(error: NetworkError.decodingFailed)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(model as! T)).eraseToAnyPublisher()
        }
    }
}
