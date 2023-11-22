//
//  UserView.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation
import UIKit

protocol UserViewDelegate: AnyObject{
    func navigateToPosts()
}


class UserView: UIView{
    weak var delegate: UserViewDelegate?
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "user_name"
        return label
    }()
    
    lazy var fullName: UILabel = {
        let label = UILabel()
        label.text = "full_name"
        return label
    }()
    
    lazy var email: UILabel = {
        let label = UILabel()
        label.text = "email"
        return label
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Posts", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy(){
        addSubview(stack)
        stack.addArrangedSubview(userName)
        stack.addArrangedSubview(fullName)
        stack.addArrangedSubview(email)
        stack.addArrangedSubview(button)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    @objc func buttonTapped(){
        delegate?.navigateToPosts()
    }
    
    func configure(user: User){
        DispatchQueue.main.async {
            self.userName.text = user.username
            self.fullName.text = user.name
            self.email.text = user.email
        }
        
    }
}
