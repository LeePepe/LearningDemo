//
//  RegisterViewController.swift
//  LearningFromBook
//
//  Created by 李天培 on 2017/1/6.
//  Copyright © 2017年 lee. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPaswordTextField: UITextField!
    @IBOutlet weak var registerWaitActivityIndicator: UIActivityIndicatorView!

    @IBAction func cancelRegister(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private struct StoryBoard {
        static let LoginSegueIdentifier = "Login"
    }
    
    @IBAction private func register() {
        guard !username.isEmpty else {
            showAlert(message: "user name empty")
            return
        }
        guard !password.isEmpty else {
            showAlert(message: "password empty")
            return
        }
        guard password == confirm else {
            showAlert(message: "confirm password is not same with password")
            return
        }
        // remote request
        registerWaitActivityIndicator.startAnimating()
        Request.main.login(user: username, password: password) { (success, error) in
            DispatchQueue.main.async { [unowned self] in
                self.registerWaitActivityIndicator.stopAnimating()
                if success {
                    UserDefaults.standard.setValue(self.username, forKey: UserInfoKey.LoginUser)
                    self.performSegue(withIdentifier: StoryBoard.LoginSegueIdentifier, sender: nil)
                } else if let error = LocalError(rawValue: error!.code) {
                    switch error {
                    case .userRepeat: self.showAlert(message: "user already exist")
                    default: self.showAlert(message: "some worry.")
                    }
                }
            }
        }
    }
    
    private func showAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    private var username: String {
        return usernameTextField?.text ?? ""
    }
    private var password: String {
        return passwordTextField?.text ?? ""
    }
    private var confirm: String {
        return confirmPaswordTextField?.text ?? ""
    }
}
