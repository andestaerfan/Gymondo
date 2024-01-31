//
//  Coordinator.swift
//  Gymondo
//
//  Created by Erfan Andesta on 29.01.24.
//

import UIKit

protocol Coordinator: AnyObject, UINavigationControllerDelegate {
    
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    func start()
    
    func childDidFinish(_ child: Coordinator?)
}
extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        if childCoordinators.isEmpty {
            parentCoordinator?.childDidFinish(child)
            child?.navigationController.delegate = parentCoordinator
            return
        }
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
