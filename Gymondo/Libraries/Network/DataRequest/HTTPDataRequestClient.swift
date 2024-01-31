//
//  HTTPDataRequestClient.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine

protocol HTTPDataRequest {
    func request(with request: URLRequest) -> AnyPublisher<Data, Error>
}
final class HTTPDataRequestClient: HTTPDataRequest {
    
    let session: DataTaskRequest
    
    init(session: DataTaskRequest = URLSession.shared) {
        self.session = session
    }
    
    func request(with request: URLRequest) -> AnyPublisher<Data, Error> {
        guard let url = request.url else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        return session.dataTaskAPI(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                if 200..<300 ~= httpResponse.statusCode {
                    return data
                } else {
                    throw NetworkError.invalidStatusCode
                }
                // can be expanded for other errors like forbidden, unauthorized, ...
            }
            .eraseToAnyPublisher()
    }
}

protocol DataTaskRequest {
    typealias Output = URLSession.DataTaskPublisher.Output
    func dataTaskAPI(for url: URL) -> AnyPublisher<Output, Error>
}

extension URLSession: DataTaskRequest {
    func dataTaskAPI(for url: URL) -> AnyPublisher<Output, Error> {
        dataTaskPublisher(for: url)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
