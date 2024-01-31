//
//  ExercisesListUseCaseTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import XCTest
@testable import Gymondo

final class ExercisesListUseCaseTests: XCTestCase {

    var sut: MainExercisesListUseCase!
    var mockAPIRequest = MockAPIRequest()
    
    override func setUp() {
        super.setUp()
        sut = MainExercisesListUseCase(apiRequester: mockAPIRequest, request: NetworkRequest(base: ""))
    }
    func test_getExercises_success() throws {
        //Given
        mockAPIRequest.fail = false
        let exercise = Exercise(id: 1, name: "name")
        mockAPIRequest.model = Exercises(results: [exercise])
        //When
        let model = try awaitPublisher(sut.getExercises())
        
        //Then
        XCTAssertFalse(model.results.isEmpty)
        XCTAssertEqual(model.results[0].id, exercise.id)
    }
    
    func test_getExercises_fail() throws {
        //Given
        mockAPIRequest.fail = true
        
        //When
        //Then
        XCTAssertThrowsError(try awaitPublisher(sut.getExercises()))
    }
    
    func test_getExerciseImage_success() throws {
        //Given
        mockAPIRequest.model = ExerciseImage(id: 1, image: "test")
        mockAPIRequest.fail = false
        //When
        let imageString = try awaitPublisher(sut.getExerciseImage(with: 1))
        
        //Then
        XCTAssertNotNil(imageString)
        XCTAssertFalse(imageString?.isEmpty ?? true)
        XCTAssertEqual(imageString, "test")
    }
    
    func test_getExerciseImage_fail() throws {
        //Given
        mockAPIRequest.fail = true
        
        //When
        //Then
        XCTAssertThrowsError(try awaitPublisher(sut.getExerciseImage(with: 2)))
    }
    func test_getExerciseImage_path() throws {
        mockAPIRequest.fail = true
        let _ = try? awaitPublisher(sut.getExerciseImage(with: 0))
        XCTAssertEqual(mockAPIRequest.request?.path, AppConstants.APIConstants.exerciseImageUrlPath + "/0")
    }
    func test_getExercises_path() throws {
        mockAPIRequest.fail = true
        let _ = try? awaitPublisher(sut.getExercises())
        XCTAssertEqual(mockAPIRequest.request?.path, AppConstants.APIConstants.exercises)
    }
}
