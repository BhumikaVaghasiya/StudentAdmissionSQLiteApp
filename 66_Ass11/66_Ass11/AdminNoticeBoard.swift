//
//  AdminNoticeBoard.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminNoticeBoard: UIViewController {
    private var studArray = [Notice]()
    
    private let myTableView = UITableView()
    
    private let AddNewButton:UIButton = {
        let button=UIButton()
        button.setTitle("+ Add New Notice", for: .normal)
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        button.layer.cornerRadius = 18
        return button
    }()
    @objc func handleClick() {
        print("add called")
        let vc = NewNotice()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studArray = SQLiteHandler.shared.fetchNotice()
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "NoticeBoard"
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .white
        myTableView.reloadData()
        myTableView.frame.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10))
        setupTableView()
        view.addSubview(myTableView)
        view.addSubview(AddNewButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        AddNewButton.frame = CGRect(x: 70, y: view.top + 75, width: 240, height: 40)
        myTableView.frame = CGRect(x: 0, y: AddNewButton.bottom + 5, width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
}

extension AdminNoticeBoard :UITableViewDataSource,UITableViewDelegate {
    private func setupTableView() {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Scell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Scell", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.textLabel!.numberOfLines = 0
        cell.backgroundColor = #colorLiteral(red: 0.6717784405, green: 0.753040731, blue: 0.9284328818, alpha: 1)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = 4
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.4
        cell.textLabel?.text = "Title : \(stud.title) \nDescription : \(stud.description)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        let vc = NewNotice()
        vc.student = studArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = studArray[indexPath.row].nid
        SQLiteHandler.shared.deleteNotice(for: id) { success in
            if success {
                self.studArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                print("Unable to Delete from View Controller.")
            }
        }
    }
}
