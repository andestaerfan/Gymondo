//
//  CustomJSONDecoder.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine

protocol JSONDecoding {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

class CustomJSONDecoder: JSONDecoding {
    
    private let decoder = JSONDecoder()
    
    init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) {
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        try decoder.decode(T.self, from: data)
    }
}

final class CustomJSONDecoderDecorator: CustomJSONDecoder {
    
    init(dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ") {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        super.init(dateDecodingStrategy: .formatted(formatter))
    }
}

extension JSONDecoder: JSONDecoding {}
