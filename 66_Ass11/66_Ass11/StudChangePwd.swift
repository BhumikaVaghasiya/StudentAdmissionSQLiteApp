//
//  StudChangePwd.swift
//  66_Ass11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudChangePwd: UIViewController {
    var stud:Student?
    private let pwdTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter New Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.isSecureTextEntry = true
        return  textField
    }()
    private let MyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.addTarget(self, action: #selector(OnUpdate), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 25
        return button
    }()
    @objc func OnUpdate()
    {
        let password = pwdTextField.text!
        if let s = stud {
           // MyButton.setTitle("Update", for: .normal)
            let updatedStud = Student(spid: s.spid, sname: s.sname, sclass: s.sclass, phone: s.phone, password: password)
            //print("Updated \(updatedStud.spid)")
            update(stud: updatedStud)
            navigationController?.popViewController(animated: true)
        }
    }
   
    private func update(stud: Student){
        SQLiteHandler.shared.update(stud: stud) { [weak self] (success) in
            if success {
                print("Success : Update successfull, received message at View Controller ")
                self?.resetFields()
            } else {
                print("Failure: Update failed, received message at View Controller ")
            }
        }
    }
    
    private func resetFields() {
        stud = nil
        pwdTextField.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bg")!)
        view.addSubview(pwdTextField)
        view.addSubview(MyButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pwdTextField.frame = CGRect(x: 27, y: 250, width: view.width - 50, height: 50)
        MyButton.frame = CGRect(x: 27, y: pwdTextField.bottom + 50, width: view.width - 50, height: 50)
    }
}
