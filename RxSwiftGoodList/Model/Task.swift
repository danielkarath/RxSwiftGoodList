//
//  Task.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/30/23.
//

import Foundation

enum Priority: Int, CaseIterable {
    case high
    case normal
    case low
    
}

struct Task {
    let title: String
    let priority: Priority
}
