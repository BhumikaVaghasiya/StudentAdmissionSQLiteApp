//
//  HomeAdmin.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class HomeAdmin: UIViewController {

    private let NoticeButton:UIButton = {
        let button = UIButton()
        button.setTitle("NoticeBoard", for: .normal)
        button.addTarget(self, action: #selector(viewNotice), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 40
        return button
    }()
    private let StudentButton:UIButton = {
        let button = UIButton()
        button.setTitle("Student Corner", for: .normal)
        button.addTarget(self, action: #selector(viewStud), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 40
        return button
    }()
    private let ClassButton:UIButton = {
        let button = UIButton()
        button.setTitle("Classes", for: .normal)
        button.addTarget(self, action: #selector(viewClass), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 40
        return button
    }()
    @objc private func viewNotice() {
        let vc = AdminNoticeBoard()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func viewStud() {
        //navigationController?.popViewController(animated: true)
        let vc = ManageStudent()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func viewClass() {
        let vc = ClassWiseStud()
        navigationController?.pushViewController(vc, animated: true)
    }
   
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.text=""
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    private let logoutButton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bg")!)
        view.addSubview(logoutButton)
        view.addSubview(usernameLabel)
        view.addSubview(NoticeButton)
        view.addSubview(StudentButton)
        view.addSubview(ClassButton)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        checkAuth()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        title = "Home"
        logoutButton.frame = CGRect(x: view.width - 100, y: 40, width: 82, height: 28)
        usernameLabel.frame = CGRect(x: 40, y: logoutButton.bottom + 40, width: view.width - 80, height: 70)
        NoticeButton.frame = CGRect(x: 25, y: usernameLabel.bottom + 100, width: view.width - 50, height: 80)
        StudentButton.frame = CGRect(x: 25, y: NoticeButton.bottom + 30, width: view.width - 50, height: 80)
        ClassButton.frame = CGRect(x: 25, y: StudentButton.bottom + 30, width: view.width - 50, height: 80)
    }
    @objc private func checkAuth() {
        if let uname = UserDefaults.standard.string(forKey: "username"){
            usernameLabel.text = "Welcome \(uname)"
        }
        else{
            let vc = Login()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav, animated: true)
        }
    }
    @objc private func logoutTapped() {
        UserDefaults.standard.setValue(nil, forKey: "username")
        checkAuth()
    }

}
