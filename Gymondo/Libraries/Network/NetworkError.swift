//
//  NetworkError.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case decodingFailed
}
