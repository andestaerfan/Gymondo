//
//  APIRequestTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import XCTest
@testable import Gymondo

final class APIRequestTests: XCTestCase {
    
    var sut: APIRequestClient!
    var mockRequest: MockNetworkRequest!
    var mockDecoder: MockDecoder!
    var mockDataRequest: MockDataRequest!
    let request = NetworkRequest(base: "https://google.com")
    
    override func setUp() {
        super.setUp()
        mockRequest = MockNetworkRequest()
        mockDecoder = MockDecoder()
        mockDataRequest = MockDataRequest()
    }
    
    func test_request_success() throws {
        //Given
        sut = APIRequestClient(decoder: mockDecoder,
                               dataRequest: mockDataRequest,
                               networkRequester: mockRequest)
        mockDecoder.fail = false
        mockDecoder.model = MockExercises(results: [MockExercise(id: 1, uuid: "uuid", name: "name", exerciseBase: 1, created: Date())])
        
        mockDataRequest.fail = false
        mockDataRequest.data = Data()
        
        mockRequest.fail = false
        mockRequest.urlRequest = URLRequest(url: URL(string: "test.com")!)
        
        
        //When
        let model: MockExercises = try awaitPublisher(sut.request(with: request))
        
        //Then
        XCTAssertFalse(model.results.isEmpty)
        XCTAssertEqual(model.results.count, 1)
        XCTAssertEqual(model.results[0].id, 1)
        XCTAssertEqual(model.results[0].uuid, "uuid")
    }
    
    func test_request_fail_request() {
        //Given
        sut = APIRequestClient(decoder: mockDecoder,
                               dataRequest: mockDataRequest,
                               networkRequester: mockRequest)
        mockDecoder.fail = false
        mockDataRequest.fail = false
        mockRequest.fail = true
        
        do {
            //When
            let _: MockExercises = try awaitPublisher(sut.request(with: request))
            //Then
            XCTFail("It should fail because of invalid request")
        } catch {
            //Then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
        }
    }
    func test_request_fail_dataRequest() {
        //Given
        sut = APIRequestClient(decoder: mockDecoder,
                               dataRequest: mockDataRequest,
                               networkRequester: mockRequest)
        mockDecoder.fail = false
        mockDataRequest.fail = true
        mockRequest.fail = false
        mockRequest.urlRequest = URLRequest(url: URL(string: "test.com")!)
        
        do {
            //When
            let _: MockExercises = try awaitPublisher(sut.request(with: request))
            //Then
            XCTFail("It should fail because of invalid request")
        } catch {
            //Then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        }
    }
    
    func test_request_fail_decoder() {
        //Given
        sut = APIRequestClient(decoder: mockDecoder,
                               dataRequest: mockDataRequest,
                               networkRequester: mockRequest)
        mockDecoder.fail = true
        mockDataRequest.fail = false
        mockDataRequest.data = Data()
        mockRequest.fail = false
        mockRequest.urlRequest = URLRequest(url: URL(string: "test.com")!)
        
        do {
            //When
            let _: MockExercises = try awaitPublisher(sut.request(with: request))
            //Then
            XCTFail("It should fail because of invalid request")
        } catch {
            //Then
            XCTAssertEqual(error as? NetworkError, NetworkError.decodingFailed)
        }
    }
}
