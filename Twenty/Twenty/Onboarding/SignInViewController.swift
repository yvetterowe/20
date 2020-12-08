//
//  SignInViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        //Hide the error label
        errorLabel.alpha = 0

        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signInBtn)
        //To do
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        //Validate Text fields
        let error = validateFields()
        if error != nil {
            showError(error!)
        }else{
            //Clean up the text fields
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                //Signing in the user
            Auth.auth().signIn(withEmail: email, password:password){(result, err) in
                if err !=  nil {
                    self.showError(err!.localizedDescription)
                }else{
                    guard let userID = result?.user.uid else {
                        fatalError("No userID")
                    }
                    self.transitionToHome(userID: userID)
                }
            }
        }

    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(userID: String){
//        let homeViewController = storyboard?.instantiateViewController(identifier: UIConstants.Storyboard.homeViewController) as? HomeViewController
//        homeViewController?.userID = userID
//        view.window?.rootViewController = homeViewController
//        view.window?.makeKeyAndVisible()
    }
}
