//
//  ViewController.swift
//  onBoardGame
//
//  Created by Hank Chou on 10/11/18.
//  Copyright © 2018 Hank Chou. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // login button
    @IBOutlet weak var loginButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // getting login status back
        self.loginButton.delegate = self
        
        // if login then head to dashboard
        if FBSDKAccessToken.current() == nil {
            // User is not already logged
            print("No Logged")
        } else {
            // User is already logged
            fetchProfile()
            
            jumpToDashboard()
            print("Already Logged")
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        } else if result.isCancelled {
            
        } else {
            // jump to Dashboard
            self.jumpToDashboard()
            print("logged in")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out")
    }
    
    func fetchProfile() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("longinerror = \(String(describing: error))")
                return
            } else {
                
                if let resultNew = result as? [String:Any] {
                    print("successfully logged in")
                    
                    let email = resultNew["email"]  as! String
                    print(email)
                    
                    let firstName = resultNew["first_name"] as! String
                    print(firstName)
                    
                    let lastName = resultNew["last_name"] as! String
                    print(lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url)
                    }
                }
            }
        })
    }
    
    func jumpToDashboard() {
        let next = storyboard?.instantiateViewController(withIdentifier: "Dashboard")
        self.present(next!, animated: true, completion: nil)
    }
}

