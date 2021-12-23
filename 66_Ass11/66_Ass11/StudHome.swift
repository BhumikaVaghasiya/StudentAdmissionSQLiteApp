//
//  StudHome.swift
//  66_Ass11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudHome: UIViewController {
   
    var stud:Student?
    
    private let LogoutButton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 7
        return button
    }()
    
    private let ViewProfileButton:UIButton = {
        let button = UIButton()
        button.setTitle("My Profile", for: .normal)
        button.addTarget(self, action: #selector(viewProfile), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 40
        return button
    }()
    
    private let NoticeButton:UIButton = {
        let button = UIButton()
        button.setTitle("View Notice Board", for: .normal)
        button.addTarget(self, action: #selector(ViewNotice), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 40
        return button
    }()
    private let ChangePwdButton:UIButton = {
        let button = UIButton()
        button.setTitle("Change Password", for: .normal)
        button.addTarget(self, action: #selector(changePwd), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 40
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bg")!)
        view.addSubview(LogoutButton)
        view.addSubview(NoticeButton)
        view.addSubview(ChangePwdButton)
        view.addSubview(ViewProfileButton)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkAuth()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        LogoutButton.frame = CGRect(x: view.width - 100, y: 80, width: 80, height: 25)
        ViewProfileButton.frame = CGRect(x: 25, y: LogoutButton.bottom + 100, width: view.width - 50, height: 80)
        NoticeButton.frame = CGRect(x: 25, y: ViewProfileButton.bottom + 20, width: view.width - 50, height: 80)
        ChangePwdButton.frame = CGRect(x: 25, y: NoticeButton.bottom + 20, width: view.width - 50, height: 80)
    }
    @objc private func checkAuth() {
        if let spid = UserDefaults.standard.string(forKey: "studspid"){
            stud = SQLiteHandler.shared.fetchStudDetail(for: Int(spid)!)
        }
        else{
            let vc = StudLogin()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav, animated: true)
        }
    }
    @objc private func logoutTapped() {
        UserDefaults.standard.setValue(nil, forKey: "studspid")
        checkAuth()
    }
     @objc private func viewProfile() {
        let vc = StudProfile()
        vc.stud = stud
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func ViewNotice() {
        navigationController?.popViewController(animated: true)
        let vc = StudNotice()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func changePwd() {
        let vc = StudChangePwd()
        vc.stud = stud
        navigationController?.pushViewController(vc, animated: true)
    }
}
