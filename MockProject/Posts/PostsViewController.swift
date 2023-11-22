//
//  ViewController.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import UIKit

class PostsViewController: UIViewController {
    
    var contentView: PostsView
    
    init(contentView: PostsView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = self.contentView
        fetchPosts()
    }
    
    func fetchPosts(){
        Networking.shared().getRequest(request: PostsRequest.posts.rawValue, responseType: [Post].self) { result in
            switch result{
                
            case .success(let posts):
                self.contentView.configure(posts: posts)
            case .failure(let error):
                print(error)
            }
        }
    }
}
