//
//  Student.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class Student {
    
    var spid : Int = 0
    var sname : String = ""
    var sclass : String = ""
    var phone: String = ""
    var password: String = ""
    
    init(){}
    init(spid:Int, sname:String ,sclass:String, phone:String, password:String)
    {
        self.spid = spid
        self.sname = sname
        self.sclass = sclass
        self.phone = phone
        self.password = password
    }
    
}
