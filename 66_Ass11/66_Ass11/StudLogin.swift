//
//  StudLogin.swift
//  66_Ass11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudLogin: UIViewController {
    
    public var pwd:String = ""
    public var spid:Int = 0
    let db = SQLiteHandler.shared
    let s = ""
    
    public  let noname:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 42)
        label.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        label.text = "Student Login"
        return label
    }()
    
    private let spidTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter spid"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        return  textField
    }()
    private let pwdTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
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
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setToolbarHidden(true, animated: false)
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bg")!)
        
        view.addSubview(loginButton)
        view.addSubview(noname)
        view.addSubview(spidTextField)
        view.addSubview(pwdTextField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noname.frame = CGRect(x: 60, y: 130, width: 300, height: 60)
        spidTextField.frame = CGRect(x: 40, y: 330, width: view.width - 80, height: 43)
        pwdTextField.frame = CGRect(x: 40, y: spidTextField.bottom + 20, width: view.width - 80, height: 43)
        loginButton.frame = CGRect(x: 40, y: pwdTextField.bottom + 50, width: view.width - 80, height: 43)
    }
    
    @objc private func loginTapped() {

        pwd = pwdTextField.text!
        spid = Int(spidTextField.text!)!
        let ans = db.StudLoginChk(for: spid, password: pwd)
        if ans{
            print("valid")
            UserDefaults.standard.setValue(spidTextField.text, forKey: "studspid")
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: false)
        }else {
            print("invaild")
        }
    }
    
}
