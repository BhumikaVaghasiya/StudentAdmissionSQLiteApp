//
//  StudNotice.swift
//  66_Ass11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudNotice: UIViewController {
    private var studArray = [Notice]()
    
    private let myTableView = UITableView()
    public  let noname:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        label.text = "NoticeBoard"
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studArray = SQLiteHandler.shared.fetchNotice()
        
        myTableView.reloadData()
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(noname)
        myTableView.reloadData()
        myTableView.frame.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10))
        setupTableView()
        
        view.addSubview(myTableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noname.frame = CGRect(x: view.width - 280, y: 65, width: 300, height: 60)
        myTableView.frame = CGRect(x: 0, y: noname.bottom , width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
}

extension StudNotice :UITableViewDataSource,UITableViewDelegate {
    private func setupTableView()
    {
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
        cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10 ,left: 10, bottom: 10, right: 10))
        cell.textLabel!.numberOfLines = 0
        cell.backgroundColor = #colorLiteral(red: 0.6717784405, green: 0.753040731, blue: 0.9284328818, alpha: 1)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = 4
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.4
        cell.textLabel?.text = "Title : \(stud.title) \nDescription : \(stud.description)  "
        return cell
    }
    
 
    
}
