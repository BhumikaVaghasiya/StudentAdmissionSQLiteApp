//
//  login.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Login: UIViewController {

    public  let noname:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 41)
        label.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        label.text = "Admin Login"
        return label
    }()
    
    
    private let nameTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Username"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        return  textField
    }()
    private let pwdTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.isSecureTextEntry = true
        return  textField
    }()
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: false)
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bg")!)
        
        view.addSubview(loginButton)
        view.addSubview(noname)
        view.addSubview(nameTextField)
        view.addSubview(pwdTextField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noname.frame = CGRect(x: 80, y: 130, width: 300, height: 70)
        nameTextField.frame = CGRect(x: 40, y: 320, width: view.width - 80, height: 50)
        pwdTextField.frame = CGRect(x: 40, y: nameTextField.bottom + 20, width: view.width - 80, height: 50)
        loginButton.frame = CGRect(x: 40, y: pwdTextField.bottom + 50, width: view.width - 80, height: 50)
    }
    
    @objc private func loginTapped() {
        UserDefaults.standard.setValue(nameTextField.text, forKey: "username")
        self.dismiss(animated: false)
    }
    
}
