//
//  ViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var SignInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
         Utilities.styleFilledButton(SignUpBtn)
         Utilities.styleFilledButton(SignInBtn)
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
