//
//  UserViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/21/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import UIKit
//import FirebaseFirestoreSwift
import Firebase

class UserViewController: UIViewController{
    @IBOutlet weak var SignOutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignOutBtnTapped(_ sender: Any) {
        print ("signout button clicked")

        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.transitionToLogin()
            print ("tried to sign out")
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    func transitionToLogin(){
        let LoginViewController = storyboard?.instantiateViewController(identifier: "Login")
        view.window?.rootViewController = LoginViewController
        view.window?.makeKeyAndVisible()
    }

}
