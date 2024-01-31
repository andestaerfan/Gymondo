//
//  MainExercisesImageHandler.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 31.01.24.
//

import XCTest
import Combine
import UIKit

@testable import Gymondo
final class MainExercisesImageHandler: XCTestCase {
    
    var sut: MainExercisesImageManager!
    var mockImageLoader = MockImageLoader()
    var mockUsecase = MockExercisesListUseCase()
    
    override func setUp() {
        super.setUp()
        //Given
        sut = MainExercisesImageManager(usecase: mockUsecase, imageLoader: mockImageLoader)
    }
    
    func test_getImage_usecase_fail() throws {
        //Given
        mockUsecase.fail = true
        
        //When
        //Then
        XCTAssertThrowsError(try awaitPublisher(sut.getExerciseImage(for: 1)))
    }
    func test_getImage_imageloader_fail() throws {
        //Given
        mockImageLoader.fail = true
        
        //When
        mockUsecase.imageString = ""
        //Then
        XCTAssertThrowsError(try awaitPublisher(sut.getExerciseImage(for: 1)))
    }
    func test_getImage_success() throws {
        //When
        mockUsecase.imageString = ""
        mockImageLoader.image = UIImage(named: "img")
        //Then
        XCTAssertNoThrow(try awaitPublisher(sut.getExerciseImage(for: 1)))
    }
    func test_getImage_cache_success() throws {
        //When
        mockUsecase.imageString = ""
        mockImageLoader.image = UIImage(named: "img")
        let _ = try awaitPublisher(sut.getExerciseImage(for: 1))
        
        //Then
        mockUsecase.imageString = nil
        XCTAssertNoThrow(try awaitPublisher(sut.getExerciseImage(for: 1)))
    }
    
}
