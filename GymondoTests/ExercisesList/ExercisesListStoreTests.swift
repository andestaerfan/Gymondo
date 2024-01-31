//
//  ExercisesListViewModelTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import XCTest
import Combine
@testable import Gymondo

final class ExercisesListStoreTests: XCTestCase {

    var sut: MainExercisesListStore!
    var mockExercisesUseCase = MockExercisesListUseCase()
    var cancellable: AnyCancellable?
    var mockExercisesImageHandler = MockMainExercisesImageHandler()
    
    override func setUp() {
        super.setUp()
        sut = MainExercisesListStore(usecase: mockExercisesUseCase, imageHandler: mockExercisesImageHandler)
    }
    func test_load_fail() throws {
        //Given
        mockExercisesUseCase.fail = true
        
        //When
        sut.load()
        
        //Then
        XCTAssertTrue(sut.exercises.isEmpty)
    }
    func test_load_success() throws {
        //Given
        mockExercisesUseCase.fail = false
        let exercise = Exercise(id: 1, name: "name")
        let exercises = Exercises(results: [exercise])
        mockExercisesUseCase.exercises = exercises
        let expectation = expectation(description: "Wait for exercises")
        
        //When
        sut.load()
        
        //Then
        cancellable = sut
            .$exercises
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { _ in
                XCTAssertFalse(self.sut.exercises.isEmpty)
                XCTAssertEqual(self.sut.exercises.count, 1)
                XCTAssertEqual(self.sut.exercises[0].name, "name")
                expectation.fulfill()
                self.cancellable?.cancel()
            })
        
        wait(for: [expectation])
    }
    
    func test_didAppear_fail() throws {
        //Given
        mockExercisesImageHandler.fail = true
        sut.exercises = [.init(id: 1, name: "")]
        
        //When
        sut.didAppear(0)
        
        //Then
        XCTAssertNil(sut.exercises[0].image)
    }
    func test_didAppear_success() throws {
        //Given
        mockExercisesImageHandler.fail = false
        mockExercisesImageHandler.image = UIImage(named: "img")
        sut.exercises = [.init(id: 1, name: "")]
        
        //When
        sut.didAppear(0)
        let expectation = expectation(description: "Getting exercises")
        
        //Then
        cancellable = sut
            .$exercises
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { _ in
                //Then
                XCTAssertEqual(self.sut.exercises[0].image, self.mockExercisesImageHandler.image)
                expectation.fulfill()
                self.cancellable?.cancel()
            })
        
        wait(for: [expectation])
        
        XCTAssertEqual(sut.exercisesImage.count, 1)
    }
    func test_didDisappear() {
        //Given
        sut.exercises = [.init(id: 1, name: "")]
        mockExercisesImageHandler.fail = true
        sut.didAppear(0)
        
        //When
        sut.didDisappear(0)
        //Then
        XCTAssertTrue(sut.exercisesImage.isEmpty)
    }
    override func tearDown() {
        super.tearDown()
        cancellable = nil
    }
}
