//
//  ExerciseDetailCoordinatorTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 29.01.24.
//

import XCTest
import UIKit
import SwiftUI
@testable import Gymondo

final class ExerciseDetailCoordinatorTests: XCTestCase {
    
    var sut: MainExerciseDetailCoordinator!
    var viewModel: MockExerciseDetailViewModel!
    var nav: UINavigationController!
    
    override func setUp() {
        super.setUp()
        //Given
        nav = UINavigationController()
        viewModel = MockExerciseDetailViewModel()
        sut = MainExerciseDetailCoordinator(navigationController: nav,
                                            viewModel: viewModel)
    }
    func test_start() {
        //When
        sut.start()
        
        //Then
        XCTAssertTrue(nav.delegate === sut)
        XCTAssertTrue(sut.childCoordinators.isEmpty)
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertNotNil(nav.viewControllers.first as? ExerciseDetailTableViewController)
    }
    
    func test_didTapOn() {
        //Given
        viewModel.detail = ExerciseDetail(images: [], variations: [1, 2, 3], name: "")
        
        //When
        //valid
        sut.didSelect(indexPath: IndexPath(row: 1, section: 1))
        // invalid
        sut.didSelect(indexPath: IndexPath(row: 0, section: 0))
        sut.didSelect(indexPath: IndexPath(row: 2, section: 2))
        sut.didSelect(indexPath: IndexPath(row: 1, section: 0))
        
        //Then
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
}
