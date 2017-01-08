//
//  LoginViewController.swift
//  LearningFromBook
//
//  Created by 李天培 on 2017/1/6.
//  Copyright © 2017年 lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginActivityIndicator: UIActivityIndicatorView!
    
    private var username: String {
        return usernameTextField?.text ?? ""
    }
    
    private var password: String {
        return passwordTextField?.text ?? ""
    }
    
    private struct StoryBoard {
        static let LoginSegueIdentifier = "Login"
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard !username.isEmpty else {
            showAlert(message: "username empty")
            return
        }
        
        guard !password.isEmpty else {
            showAlert(message: "password empty")
            return
        }
        // Remote request
        loginActivityIndicator.startAnimating()
        Request.main.login(user: username, password: password) { (success, error) in
            DispatchQueue.main.async { [unowned self] in
                self.loginActivityIndicator.stopAnimating()
                if success {
                    UserDefaults.standard.setValue(self.username, forKey: UserInfoKey.LoginUser)
                    self.performSegue(withIdentifier: StoryBoard.LoginSegueIdentifier, sender: sender)
                } else if let error = LocalError(rawValue: error!.code) {
                    switch error {
                    case .userNotExist:
                        self.showAlert(message: "user not exist.")
                    case .worryPassword:
                        self.showAlert(message: "password is worry.")
                    default:
                        self.showAlert(message: "some worry.")
                    }
                }
            }
        }
    }
    
    
    
    private func showAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
