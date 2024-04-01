//
//  Challenge.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import Foundation

struct Challenge: Hashable, Codable {
    let name: String
    let imageName: String
    let color: String
    let color_uncompleted: String
    var isCompleted: Bool = false
}
