//
//  ViewController.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import UIKit

class UserViewController: UIViewController {
    
    var contentView: UserView
    
    init(contentView: UserView) {
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
        fetchUser()
    }
    
    func fetchUser(){
        
        Networking.shared().getRequest(request: UserRequest.user.rawValue, responseType: User.self) { result in
            switch result{
                
            case .success(let user):
                self.contentView.configure(user: user)
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension UserViewController: UserViewDelegate{
    func navigateToPosts() {
        navigationController?.pushViewController(PostsFactory.build(), animated: true)
    }
}

