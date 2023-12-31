//
//  RegisterViewController.swift
//  MBtest
//
//  Created by Maxim Mitin on 3.10.23.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    private let firebaseManager = FirebaseAuthManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI(){
        emailTxtFld.placeholder = "Email"
        passwordTxtFld.placeholder = "Password"
        registerBtn.layer.cornerRadius = 15
        emailTxtFld.keyboardType = .emailAddress
        passwordTxtFld.isSecureTextEntry = true
        emailTxtFld.delegate = self
        passwordTxtFld.delegate = self
    }
    
    @IBAction func registerTaped(_ sender: Any) {
        if let email = emailTxtFld.text, let password = passwordTxtFld.text{
            firebaseManager.createUser(email: email, password: password) { success in
                if success != true {
                    self.showAlert(title: "Error", alertMessage: "Please enter correct rmail and password")
                } else {
                    self.showAlert(title: "Done", alertMessage: "User succesfully created")
                    self.emailTxtFld.text = ""
                    self.passwordTxtFld.text = ""
                }
            }
        }
    }
    
    private func showAlert(title: String, alertMessage: String){
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}
