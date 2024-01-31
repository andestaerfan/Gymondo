//
//  MockDecoder.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
@testable import Gymondo

final class MockDecoder: JSONDecoding {
    
    var fail = false
    var model: Decodable?
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if fail {
            throw NetworkError.decodingFailed
        } else {
            return model! as! T
        }
    }
}
