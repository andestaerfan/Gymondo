//
//  MockData.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation

struct MockExercises: Decodable {
    let results: [MockExercise]
}
struct MockExercise: Decodable {
    let id: Int
    let uuid: String
    let name: String
    let exerciseBase: Int
    let created: Date
}
