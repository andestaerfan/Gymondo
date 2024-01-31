//
//  ExerciseDetailCoordinator.swift
//  Gymondo
//
//  Created by Erfan Andesta on 29.01.24.
//

import UIKit

protocol ExerciseDetailViewProtocol {
    var detail: ExerciseDetail { get }
}
class MainExerciseDetailCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let viewModel: ExerciseDetailViewModelProtocol & ExerciseDetailViewProtocol
    
    init(navigationController: UINavigationController,
         viewModel: ExerciseDetailViewModelProtocol & ExerciseDetailViewProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ExerciseDetailTableViewController(viewModel: viewModel, coordinator: self)
        
        navigationController.pushViewController(vc, animated: true)
        
        /* in order to stop infinite navigation use below code
         var controllers = navigationController.viewControllers
         if controllers.count > 1 {
         controllers.removeLast()
         }
         navigationController.setViewControllers(controllers + [vc], animated: true)
         */
    }
}
extension MainExerciseDetailCoordinator: ExerciseDetailCoordinator {
    func didSelect(indexPath: IndexPath) {
        let section = indexPath.section
        guard childCoordinators.isEmpty,
              0..<Section.allCases.count ~= section,
              Section.allCases[section] == .variations,
              0..<viewModel.detail.variations.count ~= indexPath.row else { return }
        let viewModel = ExerciseDetailFactory().makeExerciseDetailViewModel(with: viewModel.detail.variations[indexPath.row])
        let coordinator = MainExerciseDetailCoordinator(navigationController: navigationController,
                                                        viewModel: viewModel)
        coordinator.parentCoordinator = self
        childCoordinators = [coordinator]
        coordinator.start()
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = viewController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(where: { $0 == fromViewController }) {
            return
        }
        if let detailVC = fromViewController as? ExerciseDetailTableViewController, let coordinator = detailVC.coordinator as? Coordinator {
            childDidFinish(coordinator)
        }
    }
}
