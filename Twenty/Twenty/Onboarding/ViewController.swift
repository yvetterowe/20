//
//  ViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import UIKit
//import FirebaseFirestoreSwift
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate {

    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var GoogleBtn:  GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        //Add Google Signin
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    @IBAction func GoogleBtnTapped(_ sender: Any) {
//        GIDSignIn.sharedInstance()?.presentingViewController = self
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            //signed in
        } else{
            GIDSignIn.sharedInstance()?.signIn()
        }
        
    }
    
    // Google Signin function
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if error != nil {
        return
      }
        let userId = user.userID
//        let _idToken = user.authentication.idToken
        let _email = user.profile.email
        print("User email: \(_email ?? "No Email")")
        //Firebase signin
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
        accessToken: authentication.accessToken)
        

        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebaes signin error: \(error)")
                return
            }
            self.transitionToHome(userID: userId!)
            print("User is signed in with Firebase")
        }
    }
    

    func setUpElements(){
         Utilities.styleFilledButton(SignUpBtn)
         Utilities.styleFilledButton(SignInBtn)
    }
    
    func transitionToHome(userID: String){
        let homeViewController = storyboard?.instantiateViewController(identifier: UIConstants.Storyboard.homeViewController) as? HomeViewController
        homeViewController?.userID = userID
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
