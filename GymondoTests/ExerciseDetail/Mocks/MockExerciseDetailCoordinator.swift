//
//  MockExerciseDetailCoordinator.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 29.01.24.
//

import Foundation
import UIKit

@testable import Gymondo

final class MockExerciseDetailCoordinator: NSObject, Coordinator, ExerciseDetailCoordinator {
    
    var count = 0
    var navigationController: UINavigationController = UINavigationController()
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    func start() {}
    
    
    func didSelect(indexPath: IndexPath) {
        count += 1
    }
}
