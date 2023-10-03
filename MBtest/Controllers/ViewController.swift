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

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    private var isLogedIn = false
    private let firebaseManager = FirebaseAuthManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTxtField.text = ""
        passwordTxtField.text = ""
    }
    
    private func setupUI() {
        emailTxtField.keyboardType = UIKeyboardType.emailAddress
        passwordTxtField.isSecureTextEntry = true
        
        loginBtn.layer.cornerRadius = 15
        registerBtn.layer.cornerRadius = 15
        
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    @IBAction func loginTaped(_ sender: Any) {
        guard let email = emailTxtField.text, let password = passwordTxtField.text else { return}
        firebaseManager.signIn(email: email, pass: password) { success in
            if success == true {
                self.performSegue(withIdentifier: "toBoard", sender: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Wrong credentials", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
        }
    }
    

}

