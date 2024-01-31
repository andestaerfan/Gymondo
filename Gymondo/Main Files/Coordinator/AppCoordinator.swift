//
//  AppCoordinator.swift
//  Gymondo
//
//  Created by Erfan Andesta on 29.01.24.
//

import Foundation
import SwiftUI

class AppCoordinator: NSObject, Coordinator {
    
    var parentCoordinator: Coordinator? = nil
    let window: UIWindow
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow, navigationController: UINavigationController = .init()) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let factory = ExercisesListFactory()
        let store = factory.makeExercisesListStore()
        let exerciseListCoordinator = MainExercisesListViewCoordinator(navigationController: navigationController,
                                                              store: store)
        childCoordinators = [exerciseListCoordinator]
        exerciseListCoordinator.parentCoordinator = self
        exerciseListCoordinator.start()
        
        window.rootViewController = exerciseListCoordinator.navigationController
        window.makeKeyAndVisible()
    }
}
