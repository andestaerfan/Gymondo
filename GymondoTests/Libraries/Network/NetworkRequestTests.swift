//
//  NetworkRequestTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import XCTest
@testable import Gymondo

final class NetworkRequestTests: XCTestCase {
    
    var sut: NetworkRequesterClient!
    
    override func setUp() {
        super.setUp()
        sut = NetworkRequesterClient()
    }
    func test_networkRequestCreator_inValidUrl() {
        //Given
        var model = NetworkRequest(base: "http://example .com")
        model.path = "invalid"
        do {
            //When
            let url = try awaitPublisher(sut.createRequest(request: model))
            //Then
            XCTFail("It should fail for \(url)")
        } catch let error as NetworkError {
            //Then
            XCTAssert(error == NetworkError.invalidURL)
        } catch {
            XCTFail("Error is not NetworkError")
        }
    }
    func test_networkRequestCreator_valid() throws {
        //Given
        var model = NetworkRequest(base: "http://example.com")
        model.path = "test"
        model.queryItems = ["name": "John Doe"]
        model.method = .post
        model.headers = ["Content-Type": "application/json"]
        
        //When
        let req = try awaitPublisher(sut.createRequest(request: model))
        //Then
        XCTAssertEqual(req.url?.absoluteString, "http://example.com/test?name=John%20Doe")
        XCTAssertEqual(req.httpMethod, model.method.rawValue)
        XCTAssertEqual(req.allHTTPHeaderFields, model.headers)
    }
}
