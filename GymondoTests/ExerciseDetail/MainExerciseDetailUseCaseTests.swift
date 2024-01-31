//
//  ExerciseDetailUseCaseTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import XCTest
@testable import Gymondo

final class MainExerciseDetailUseCaseTests: XCTestCase {

    var sut: MainExerciseDetailUseCase!
    var mockAPIRequest = MockAPIRequest()
    
    override func setUp() {
        super.setUp()
        sut = MainExerciseDetailUseCase(apiRequester: mockAPIRequest, request: NetworkRequest(base: ""))
    }
    
    func test_getExerciseDetail_path() throws {
        mockAPIRequest.fail = true
        let _ = try? awaitPublisher(sut.getExerciseDetail(for: 0))
        XCTAssertEqual(mockAPIRequest.request?.path, AppConstants.APIConstants.exerciseInfoPath + "/0")
    }
    func test_getExerciseDetail_success() throws {
        //Given
        mockAPIRequest.fail = false
        mockAPIRequest.model = ExerciseDetail(images: [ExerciseDetail.ExerciseImage(image: "image1")], variations: [1, 2], name: "title")
        //When
        let model = try awaitPublisher(sut.getExerciseDetail(for: 0))
        
        //Then
        XCTAssertEqual(model.images.map(\.image), ["image1"])
        XCTAssertEqual(model.variations, [1, 2])
        XCTAssertEqual(model.name, "title")
    }
    
    func test_getExerciseDetail_fail() throws {
        //Given
        mockAPIRequest.fail = true
        
        //When
        //Then
        XCTAssertThrowsError(try awaitPublisher(sut.getExerciseDetail(for: 0)))
    }

}
