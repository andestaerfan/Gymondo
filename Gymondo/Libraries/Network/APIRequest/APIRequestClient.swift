//
//  APIRequestClient.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine

protocol APIRequest {
    func request<T: Decodable>(with request: NetworkRequestModel) -> AnyPublisher<T, Error>
}
final class APIRequestClient: APIRequest {
    
    private let decoder: JSONDecoding
    private let dataRequest: HTTPDataRequest
    private let networkRequester: NetworkRequester
    
    init(decoder: JSONDecoding = JSONDecoder(),
         dataRequest: HTTPDataRequest = HTTPDataRequestClient(),
         networkRequester: NetworkRequester = NetworkRequesterClient()) {
        self.decoder = decoder
        self.dataRequest = dataRequest
        self.networkRequester = networkRequester
    }
    
    func request<T: Decodable>(with request: NetworkRequestModel) -> AnyPublisher<T, Error> {
        return networkRequester
            .createRequest(request: request)
            .flatMap { self.dataRequest.request(with: $0) }
            .tryMap { data in
                try self.decoder.decode(T.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
