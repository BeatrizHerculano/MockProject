//
//  UserView.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation
import UIKit




class PostsView: UIView{
    
    var posts:[Post] = []
    
    lazy var table: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        return tableView
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Post"
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
        addSubview(table)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: topAnchor),
            table.leadingAnchor.constraint(equalTo: leadingAnchor),
            table.trailingAnchor.constraint(equalTo: trailingAnchor),
            table.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func configure(posts: [Post]){
        DispatchQueue.main.async {
            self.posts = posts
            self.table.reloadData()
        }
        
    }
    
}

extension PostsView: UITableViewDelegate{
    
}

extension PostsView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    
}
