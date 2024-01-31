//
//  NetworkDataRequestTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import XCTest
@testable import Gymondo

final class NetworkDataRequestTests: XCTestCase {
    
    var sut: HTTPDataRequest!
    var mockSession = MockURLSession()
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = HTTPDataRequestClient(session: mockSession)
    }
    
    func test_request_success() throws {
        //Given
        mockSession.response = HTTPURLResponse(url: URL(string: "htt")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        //When
        let pub = sut.request(with: URLRequest(url: URL(string: "https://google.com")!))
        
        //Then
        XCTAssertNoThrow(try awaitPublisher(pub), "It should pass")
    }
    
    func test_request_fail_invalidStatusCode() throws {
        //Given
        mockSession.response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 300, httpVersion: nil, headerFields: nil)!
        
        //When
        let pub = sut.request(with: URLRequest(url: URL(string: "https://google.com")!))
        
        //Then
        do {
            let _ = try awaitPublisher(pub)
            XCTFail("It should fail")
        } catch {
            guard let error = error as? NetworkError else {
                XCTFail("It should be network error")
                return
            }
            XCTAssertTrue(error == NetworkError.invalidStatusCode)
        }
    }
    
    func test_request_fail() throws {
        //Given
        mockSession.fail = true
        
        //When
        let pub = sut.request(with: URLRequest(url: URL(string: "https://google.com")!))
        
        //Then
        do {
            let _ = try awaitPublisher(pub)
            XCTFail("It should fail")
        } catch {
            guard let error = error as? NetworkError else {
                XCTFail("It should be network error")
                return
            }
            XCTAssertTrue(error == NetworkError.invalidURL)
        }
    }
    
    func test_request_fail_invalidResponse() throws {
        //Given
        mockSession.response = URLResponse()
        
        //When
        let pub = sut.request(with: URLRequest(url: URL(string: "https://google.com")!))
        
        //Then
        do {
            let _ = try awaitPublisher(pub)
            XCTFail("It should fail")
        } catch {
            guard let error = error as? NetworkError else {
                XCTFail("It should be network error")
                return
            }
            XCTAssertTrue(error == NetworkError.invalidResponse)
        }
    }
    
}
