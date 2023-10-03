//
//  RegisterViewController.swift
//  MBtest
//
//  Created by Maxim Mitin on 3.10.23.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI(){
        emailTxtFld.placeholder = "Email"
        passwordTxtFld.placeholder = "Password"
        registerBtn.layer.cornerRadius = 15
    }
    
    @IBAction func registerTaped(_ sender: Any) {
    }
    

}
