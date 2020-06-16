//
//  GoogleSignInViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/15/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class GoogleSignInViewController: UIViewController {
    @IBOutlet weak var GoogleSignInBtn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
