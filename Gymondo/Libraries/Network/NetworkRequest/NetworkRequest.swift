//
//  NetworkRequest.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol NetworkRequestModel {
    var base: String { get }
    var path: String { get set }
    var queryItems: [String: String]? { get set }
    var method: HTTPMethods { get set }
    var headers: [String: String]? { get set }
}
struct NetworkRequest: NetworkRequestModel {
    
    let base: String
    
    var path = ""
    var queryItems: [String: String]?
    var method: HTTPMethods = .get
    var headers: [String: String]?
    
    init(base: String) {
        self.base = base
    }
}
