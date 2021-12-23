//
//  StudProfile.swift
//  66_Ass11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudProfile: UIViewController {
    var stud:Student?
    public  let noname:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        label.text = "My Profile"
        return label
    }()
    
    private let sDetails:UILabel = {
        let label = UILabel()
        label.text=""
        label.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.addSubview(noname)
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bg")!)
        title = "My Profile"
        view.addSubview(sDetails)
        if let s : Student = stud{
            let id = s.spid
            let name = s.sname
            let sclass = s.sclass
            let phone = s.phone
            let pwd = s.password
            sDetails.text = "SPID : \(id) \nName: \(name) \nClass: \(sclass) \nPhone: \(phone) \nPassword: \(pwd)"
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noname.frame = CGRect(x: 100, y: 140, width: 300, height: 60)
        sDetails.frame = CGRect(x: 38, y: view.height - 400, width: 300, height: 200)
    }
}
