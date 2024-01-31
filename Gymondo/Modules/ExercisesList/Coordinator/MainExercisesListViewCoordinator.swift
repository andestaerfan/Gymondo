//
//  ExerciseListCoordinator.swift
//  Gymondo
//
//  Created by Erfan Andesta on 29.01.24.
//

import UIKit
import SwiftUI

class MainExercisesListViewCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private let store: MainExercisesListStore
    
    init(navigationController: UINavigationController,
         store: MainExercisesListStore) {
        self.navigationController = navigationController
        self.store = store
    }
    
    func start() {
        navigationController.delegate = self
        let view = ExercisesListView(store: store, coordinator: self)
        let viewController = UIHostingController(rootView: view)
        navigationController.viewControllers = [viewController]
    }
}
extension MainExercisesListViewCoordinator: ExercisesListViewCoordinator {
    func didTapOn(index: Int) {
        guard childCoordinators.isEmpty,
            0..<store.exercises.count ~= index else { return }
        showExerciseDetail(store.exercises[index].id)
    }
    private func showExerciseDetail(_ id: Int) {
    }
}
extension MainExercisesListViewCoordinator {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = viewController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(where: { $0 == fromViewController }) {
            return
        }
        
    }
}
