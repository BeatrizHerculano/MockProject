//
//  UserFactory.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation
import UIKit


class UserFactory{
    static func build() -> UIViewController{
        let view = UserView()
        let vc = UserViewController(contentView: view)
        view.delegate = vc
        return vc
    }
}
