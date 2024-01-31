//
//  ImageCollectionViewCellTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 28.01.24.
//

import XCTest
import Combine
@testable import Gymondo

final class ImageCollectionViewCellTests: XCTestCase {

    var sut: ImageCollectionViewCell!
    var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        //Given
        sut = ImageCollectionViewCell(frame: .zero)
    }
    
    func test_imageView_added() {
        XCTAssertFalse(sut.subviews.isEmpty)
    }
    func test_binding_fail() {
        //When
        let error = Fail<UIImage?, Error>(error: NSError(domain: "error", code: 1))
            .eraseToAnyPublisher()
        sut.bind(publisher: error)
        
        //Then
        XCTAssertNil(sut.imageView.image)
    }
    func test_binding_success() throws {
        //When
        let image = Result<UIImage?, Error>.Publisher(.success(UIImage(named: "img")))
            .eraseToAnyPublisher()
        sut.bind(publisher: image)
        let expectation = expectation(description: "Wait for image")
        //Then
        cancellable = image
            .receive(on: DispatchQueue.main)
                   .sink { _ in
                   } receiveValue: { [weak self] image in
                       XCTAssertEqual(self?.sut.imageView.image, UIImage(named: "img"))
                       expectation.fulfill()
                   }
        
        wait(for: [expectation])
    }
}
