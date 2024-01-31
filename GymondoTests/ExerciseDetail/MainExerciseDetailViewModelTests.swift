//
//  ExerciseDetailViewModelTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import XCTest
import Combine

@testable import Gymondo

final class MainExerciseDetailViewModelTests: XCTestCase {
    
    var sut: MainExerciseDetailViewModel!
    var mockExercisesUseCase = MockExerciseDetailUseCase()
    var mockImageLoader = MockImageLoader()
    
    override func setUp() {
        super.setUp()
        //Given
        sut = MainExerciseDetailViewModel(usecase: mockExercisesUseCase,
                                      imageLoader: mockImageLoader,
                                      dataSource: ExerciseDetailDataSource(imagesDataSource: ExerciseImagesDataSource()),
                                      id: 1)
    }
    
    func test_initial_data() {
        XCTAssertEqual(sut.detail.name, "")
        XCTAssertTrue(sut.detail.variations.isEmpty)
        XCTAssertTrue(sut.detail.images.isEmpty)
    }
    func test_load_data() throws {
        //Given
        mockExercisesUseCase.exerciseDetail = ExerciseDetail(images: [.init(image: "https://test.com")], variations: [1, 2], name: "name")
        mockImageLoader.image = UIImage(named: "img")
        
        //When
        try awaitPublisher(sut.load())
        
        //Then
        XCTAssertEqual(sut.detail.name, "name")
        XCTAssertEqual(sut.detail.variations, [1, 2])
        XCTAssertEqual(sut.detail.images.map(\.image), ["https://test.com"])
        
        let image = try awaitPublisher((sut.dataSource as! ExerciseDetailDataSource).imagesDataSource.images[0])
        XCTAssertEqual(image, mockImageLoader.image)
    }
}
