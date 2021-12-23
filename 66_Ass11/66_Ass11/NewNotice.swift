//
//  NewNotice.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNotice: UIViewController {
    var student:Notice?
    
    let temp = SQLiteHandler.shared
    
    public let nameTextField1:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Title"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        return textField
    }()
    public let classTextField2:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Description"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        return textField
    }()
    
    private let MyButton:UIButton={
        let button=UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(OnInsertButtonClick), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 25
        return button
    }()
    
    @objc func OnInsertButtonClick()
    {
        let title = nameTextField1.text!
        let description = classTextField2.text!
        
        if let stud = student {
            MyButton.setTitle("Update", for: .normal)
            let updatedStud = Notice(nid: stud.nid, title: title, description: description)
            print("Update \(updatedStud)")
            update(stud: updatedStud)
            navigationController?.popViewController(animated: true)
        } else {
            let No = Notice(nid: 1,title: title, description: description)
            print("INSERT \(title), \(description)")
            insert(stud: No)
            navigationController?.popViewController(animated: true)
            
        }
    }
    private func insert(stud: Notice){
        SQLiteHandler.shared.insertNotice(no: stud) { [weak self] (success) in
            if success {
                print("Success : Insert successfull, received message at View Controller ")
                self?.resetFields()
            } else {
                print("Failure: Insert failed, received message at View Controller ")
            }
        }
    }
    
    private func update(stud: Notice){
        SQLiteHandler.shared.updateNotice(no: stud) { [weak self] (success) in
            if success {
                print("Success : Update successfull, received message at View Controller ")
                self?.resetFields()
            } else {
                print("Failure: Update failed, received message at View Controller ")
            }
        }
    }
    
    private func resetFields() {
        student = nil
        nameTextField1.text = ""
        classTextField2.text = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bg")!)
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.addSubview(nameTextField1)
        view.addSubview(classTextField2)
        view.addSubview(MyButton)
        
        if let stud = student {
            nameTextField1.text = stud.title
            classTextField2.text = stud.description
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField1.frame = CGRect(x: 27, y: view.safeAreaInsets.top + 180, width: view.width - 50, height: 50)
        classTextField2.frame = CGRect(x: 27, y:nameTextField1.bottom + 10, width: view.width - 50, height: 50)
        MyButton.frame = CGRect(x: 27, y: classTextField2.bottom + 20, width: view.width - 50, height: 50)
    }
    
}
