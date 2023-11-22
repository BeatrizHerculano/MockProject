//
//  Posts.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
