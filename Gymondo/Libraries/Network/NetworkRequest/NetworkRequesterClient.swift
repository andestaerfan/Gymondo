//
//  NetworkRequesterClient.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine

protocol NetworkRequester {
    func createRequest(request: NetworkRequestModel) -> AnyPublisher<URLRequest, Error>
}
final class NetworkRequesterClient: NetworkRequester {
    
    func createRequest(request: NetworkRequestModel) -> AnyPublisher<URLRequest, Error> {
        guard var components = URLComponents(string: request.base + "/" + request.path) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        var queryItems = [URLQueryItem]()
        for (key, value) in request.queryItems ?? [:] {
            let query = URLQueryItem(name: key, value: value)
            queryItems.append(query)
        }
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        return Result.Publisher(.success(urlRequest))
            .eraseToAnyPublisher()
    }
}
