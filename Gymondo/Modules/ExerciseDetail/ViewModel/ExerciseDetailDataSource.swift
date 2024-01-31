//
//  ExerciseDetailDataSource.swift
//  Gymondo
//
//  Created by Erfan Andesta on 28.01.24.
//

import Foundation
import UIKit
import Combine

protocol ExerciseDetailDataSourceProtocol: UITableViewDataSource {
    func setData(title: String, variations: [Int], images: [AnyPublisher<UIImage?, Error>])
}
final class ExerciseDetailDataSource: NSObject, ExerciseDetailDataSourceProtocol {
    
    let imagesDataSource: ExerciseImagesDataSourceProtocol
    private(set) var variations = [Int]()
    private(set) var title = ""
    
    init(imagesDataSource: ExerciseImagesDataSourceProtocol) {
        self.imagesDataSource = imagesDataSource
    }
    
    func setData(title: String, variations: [Int], images: [AnyPublisher<UIImage?, Error>]) {
        self.title = title
        self.variations = variations
        imagesDataSource.images = images
    }
}
extension ExerciseDetailDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        switch section {
        case .name, .images:
            return 1
        case .variations:
            return variations.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section.allCases[section].rawValue.uppercased()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .name, .variations:
            let cell: UITableViewCell = {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) else {
                    return UITableViewCell(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
                }
                return cell
            }()
            var content = cell.defaultContentConfiguration()
            content.textProperties.color = .orange
            if section == .name {
                content.text = title
            } else {
                content.text = "\(variations[indexPath.row])"
            }
            cell.contentConfiguration = content
            return cell
        case .images:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExerciseImagesTableViewCell.self), for: indexPath) as? ExerciseImagesTableViewCell else { return UITableViewCell() }
            cell.set(dataSource: imagesDataSource)
            
            return cell
        }
    }
}
