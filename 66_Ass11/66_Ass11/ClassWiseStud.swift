//
//  ClassWiseStud.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ClassWiseStud: UIViewController {
    private var studArray = [Student]()
    private let myTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studArray = SQLiteHandler.shared.fetchClass()
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Classes"
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .white
        myTableView.reloadData()
        setupTableView()
        view.addSubview(myTableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTableView.frame = CGRect(x: 0, y: 10, width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
}

extension ClassWiseStud :UITableViewDataSource,UITableViewDelegate {
    private func setupTableView()
    {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Classcell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Classcell", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.textLabel?.text = "\(stud.sclass)"
        
        cell.layer.cornerRadius = 20
        cell.backgroundColor = #colorLiteral(red: 0.6717784405, green: 0.753040731, blue: 0.9284328818, alpha: 1)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 4
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        let stud = studArray[indexPath.row]
        let vc = StudListClassWise()
        vc.selClass = String(stud.sclass)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
