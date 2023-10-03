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
    private let firebaseManager = FirebaseAuthManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupKeyboardHiding()
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

//MARK: - ext for view and kboard delegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTxtFld = UIResponder.currentFirst() as? UITextField else {return}
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTxtFld.frame, from: currentTxtFld.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

//MARK: - extensin for Responder
extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
    
}

