//
//  Notice.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class Notice {
    
    var nid : Int = 0
    var title : String = ""
    var description : String = ""
   
    init(nid:Int, title:String ,description:String)
    {
        self.nid = nid
        self.title = title
        self.description = description
    }
    
}
