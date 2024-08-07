//
//  Item.swift
//  ToDO Application
//
//  Created by Parth Kumar on 7/29/24.
//

import Foundation
struct Item: Identifiable, Codable {
    let id = UUID()
    var todo: String
    var dateCreated: Date
}
