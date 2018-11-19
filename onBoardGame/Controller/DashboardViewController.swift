//
//  DashboardViewController.swift
//  onBoardGame
//
//  Created by Hank Chou on 12/11/18.
//  Copyright © 2018 Hank Chou. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SideMenu


class DashboardViewController: UIViewController{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load user info when login
        getUserInfo()
        
    }
    
    // load user info
    func getUserInfo() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("login failed")
                print("longinerror = \(String(describing: error))")
                return
            } else {
                
                if let resultNew = result as? [String:Any] {
                    print("successfully logged in")
                    
                    let email = resultNew["email"]  as! String
                    print(email)
                    
                    let firstName = resultNew["first_name"] as! String
                    self.userName.text = "Welcome \(firstName)"
                    print(firstName)
                    
                    let lastName = resultNew["last_name"] as! String
                    print(lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        self.userProfileImage.image = UIImage(data: NSData(contentsOf: NSURL(string: url)! as URL)! as Data)
                        print(url)
                    }
        
                }
            }
        })
    }
}
