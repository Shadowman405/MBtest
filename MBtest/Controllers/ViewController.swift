//
//  ViewController.swift
//  MBtest
//
//  Created by Maxim Mitin on 2.10.23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    private var isLogedIn = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        emailTxtField.keyboardType = UIKeyboardType.emailAddress
        passwordTxtField.isSecureTextEntry = true
        
        loginBtn.layer.cornerRadius = 15
        registerBtn.layer.cornerRadius = 15
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

}

