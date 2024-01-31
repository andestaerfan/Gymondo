//
//  ImageLoaderTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import XCTest
import Combine
@testable import Gymondo

final class ImageLoaderTests: XCTestCase {

    var sut: ImageLoaderClient!
    var mockDataRequest = MockDataRequestImageLoader()

    override func setUp() {
        super.setUp()
        sut = ImageLoaderClient(dataRequest: mockDataRequest)
    }
    
    func test_getImage_fail() throws {
        //Given
        sut = ImageLoaderClient(dataRequest: mockDataRequest)
        mockDataRequest.fail = true
        
        //When
        //Then
        XCTAssertThrowsError(try awaitPublisher(sut.getImage(for: "https://test.com")))
    }
    func test_getImage_success() throws {
        //Given
        mockDataRequest.fail = false
        mockDataRequest.data = UIImage(named: "img")!.pngData()
        //When
        //Then
        let image = try awaitPublisher(sut.getImage(for: "https://test.com"))
        XCTAssertEqual(mockDataRequest.data, image?.pngData())
    }
    func test_getImage_status_fetched() throws {
        //Given
        mockDataRequest.fail = false
        mockDataRequest.data = UIImage(named: "img")!.pngData()
        //When
        let _ = try awaitPublisher(sut.getImage(for: "https://test.com"))
        let _ = try awaitPublisher(sut.getImage(for: "https://test.com"))
        //Then
        XCTAssertEqual(mockDataRequest.count, 1)
    }
}
class MockDataRequestImageLoader: MockDataRequest {
    var count = 0
    
    override func request(with request: URLRequest) -> AnyPublisher<Data, Error> {
        count += 1
        return super.request(with: request)
    }
}
