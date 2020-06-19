//
//  ViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var GoogleBtn:  GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
//        if GIDSignIn.sharedInstance()?.currentUser != nil {
//            //signed in
//        } else{
//            GIDSignIn.sharedInstance()?.signIn()
//        }
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    func setUpElements(){
         Utilities.styleFilledButton(SignUpBtn)
         Utilities.styleFilledButton(SignInBtn)
    }
}
