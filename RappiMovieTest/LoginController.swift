//
//  LoginController.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/11/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController, UITextFieldDelegate {
    
    var activeTextField: UITextField!
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .green
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.textColor = .black
        return tf
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.textColor = .black
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("login", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScrollView()
    }
    
    func setupView() {
        view.backgroundColor = .cyan
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        scrollView.keyboardDismissMode = .onDrag
        
        scrollView.addSubview(usernameTextField)
        usernameTextField.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: view.frame.width - 16, height: 40)
        
        scrollView.addSubview(passwordTextField)
        passwordTextField.anchor(top: usernameTextField.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: view.frame.width - 16, height: 40)
        
        scrollView.addSubview(loginButton)
        loginButton.anchor(top: passwordTextField.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 8, paddingBottom: 10, paddingRight: 8, width: view.frame.width - 16, height: 40)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 60, 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect: CGRect = self.view.frame
            aRect.size.height -= keyboardSize.height + 60
            if let activeTextView = self.activeTextField {
                let activeTextViewCGPoint = CGPoint(x: activeTextView.frame.minX, y: activeTextView.frame.maxY)
                if (!aRect.contains(activeTextViewCGPoint)) {
                    self.scrollView.scrollRectToVisible(activeTextView.frame, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillHidden(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleLogin() {
        AuthService.instance.getRequestToken(username: usernameTextField.text!, password: passwordTextField.text!) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
