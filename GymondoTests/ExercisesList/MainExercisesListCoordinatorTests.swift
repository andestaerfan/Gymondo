//
//  MainExercisesListCoordinatorTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 29.01.24.
//

import XCTest
import UIKit
import SwiftUI
@testable import Gymondo

final class MainExercisesListCoordinatorTests: XCTestCase {
    
    var sut: MainExercisesListViewCoordinator!
    var store: MainExercisesListStore!
    var nav: UINavigationController!
    
    override func setUp() {
        super.setUp()
        //Given
        nav = UINavigationController()
        store = MainExercisesListStore(usecase: MockExercisesListUseCase(), imageHandler: MockMainExercisesImageHandler())
        sut = MainExercisesListViewCoordinator(navigationController: nav,
                                               store: store)
    }
    func test_start() {
        //When
        sut.start()
        
        //Then
        XCTAssertTrue(nav.delegate === sut)
        XCTAssertTrue(sut.childCoordinators.isEmpty)
        XCTAssertEqual(nav.viewControllers.count, 1)
        let hostingController = nav.viewControllers.first as? UIHostingController<ExercisesListView>
        XCTAssertNotNil(hostingController?.rootView as? ExercisesListView)
    }
    
    func test_didTapOn() {
        //Given
        store.exercises = [.init(id: 1, name: "")]
        
        //When
        sut.didTapOn(index: 0)
        sut.didTapOn(index: 0)
        sut.didTapOn(index: 1)
        sut.didTapOn(index: -1)
        
        //Then
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
}
