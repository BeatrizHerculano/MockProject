//
//  UserFactory.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation
import UIKit


class PostsFactory{
    static func build() -> UIViewController{
        let view = PostsView()
        let vc = PostsViewController(contentView: view)
        return vc
    }
}
