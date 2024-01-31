//
//  MockDataRequest.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine
@testable import Gymondo

class MockDataRequest: HTTPDataRequest {
    
    var fail = false
    var data: Data?
    
    func request(with request: URLRequest) -> AnyPublisher<Data, Error> {
        if fail {
            return Fail(error: NetworkError.invalidResponse)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(data!))
                .eraseToAnyPublisher()
        }

    }
}
