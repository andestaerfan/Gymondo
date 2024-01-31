//
//  MockURLSession.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine
@testable import Gymondo

class MockURLSession: DataTaskRequest {
    
    var fail = false
    var response = URLResponse()
    
    func dataTaskAPI(for url: URL) -> AnyPublisher<Output, Error> {
        if fail {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        } else {
            let result = (data: Data(), response: response)
            return Result.Publisher(.success(result)).eraseToAnyPublisher()
        }
    }
}
