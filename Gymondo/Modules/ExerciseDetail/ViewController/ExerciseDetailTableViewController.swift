//
//  ExerciseDetailTableViewController.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import UIKit
import Combine

protocol ExerciseDetailViewModel {
    func load() -> AnyPublisher<Void, Error>
    var dataSource: ExerciseDetailDataSourceProtocol { get }
}
protocol ExerciseDetailCoordinator: AnyObject {
    func didSelect(indexPath: IndexPath)
}
class ExerciseDetailTableViewController: UIViewController {
    
    private(set) var viewModel: ExerciseDetailViewModelProtocol
    private(set) var cancellables = [AnyCancellable]()
    private(set) var tableView: UITableView
    weak var coordinator: ExerciseDetailCoordinator?
    
    init(viewModel: ExerciseDetailViewModelProtocol,
         tableView: UITableView = UITableView(),
         coordinator: ExerciseDetailCoordinator?) {
        self.viewModel = viewModel
        self.tableView = tableView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        load()
    }
    
    func load() {
        viewModel
            .load()
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellables)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let topConstraint = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        tableView.register(ExerciseImagesTableViewCell.self, forCellReuseIdentifier: String(describing: ExerciseImagesTableViewCell.self))
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = self
    }
}
extension ExerciseDetailTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Section.allCases[indexPath.section] == .images {
            return 100
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.didSelect(indexPath: indexPath)
    }
}
