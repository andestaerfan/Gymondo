//
//  MockNetworkRequest.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine
@testable import Gymondo

final class MockNetworkRequest: NetworkRequester {
    
    var fail = false
    var urlRequest: URLRequest?
    
    func createRequest(request: NetworkRequestModel) -> AnyPublisher<URLRequest, Error> {
        if fail {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(.success(urlRequest!))
                .eraseToAnyPublisher()
        }

    }
}
