//
//  SQLiteHandler.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import SQLite3
class SQLiteHandler {
    
    static let shared = SQLiteHandler()
    
    let dbPath = "StudAdmissiondb.sqlite"
    var db:OpaquePointer?  //Database Pointer
    
    private init()
    {
        db=openDatabase()
        createTable()
        createTableNotice()
    }
    
    func openDatabase() -> OpaquePointer? {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = docURL.appendingPathComponent(dbPath)
        
        var database:OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK {
            
            print("Opened Connection to the database successfully at : \(fileURL)")
            return database
        } else {
            print("error eonnecting to the database")
            return nil
        }
    }
    
    
    func createTable() {
        //Sql statement
        let createTableString = """
        CREATE TABLE IF NOT EXISTS student(
        spid INTEGER PRIMARY KEY AUTOINCREMENT,
        sname TEXT,
        sclass TEXT,
        phone TEXT,
        password TEXT
        );
        """
        
        //statement handle
        var createTableStatement:OpaquePointer? = nil
        
        //prepare Statement
        if sqlite3_prepare_v2(db, createTableString, -1 , &createTableStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("student table created")
            } else {
                print("student table could not be prepared")
            }
        }
        else
        {
            print("student table could not be prepared")
        }
        
        //delete statement
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(stud:Student, completion: @escaping ((Bool) -> Void)) {
        let insertStatementString = "INSERT INTO student(sname, sclass, phone,password) VALUES(?, ?, ?, ?);"
        
        var insertStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, insertStatementString, -1 ,&insertStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(insertStatement, 1, (stud.sname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (stud.sclass as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (stud.phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (stud.password as NSString).utf8String, -1, nil)
            
            //Evaluate statement
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("inserted row succesfully")
                completion(true)
            } else {
                print("could not insert row")
                completion(false)
            }
            
        }
        else
        {
            print("insert statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(insertStatement)
        
    }
    
    func update(stud:Student, completion: @escaping ((Bool) -> Void)) {
        let updateStatementString = "UPDATE student SET sname = ?, sclass = ?, phone = ?, password = ? WHERE spid = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, updateStatementString, -1 ,&updateStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(updateStatement, 1, (stud.sname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (stud.sclass as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (stud.phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (stud.password as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 5, Int32(stud.spid))
            
            //Evaluate statement
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("updated row succesfully")
                completion(true)
            } else {
                print("could not update row")
                completion(false)
            }
            
        }
        else
        {
            print("UPDATE statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(updateStatement)
        
    }
    
    func delete(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deleteStatementString = "DELETE FROM student WHERE spid = ?;"
        
        var deleteStatement:OpaquePointer? = nil
        
        //prepare deleteStatement
        if sqlite3_prepare_v2(db, deleteStatementString, -1 ,&deleteStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            //Evaluate statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("deleted row succesfully")
                completion(true)
            } else {
                print("could not delete row")
                completion(false)
            }
            
        }
        else
        {
            print("Delete statement could not be prepared")
            completion(false)
        }
        
        //delete deletestatement
        sqlite3_finalize(deleteStatement)
        
    }
    
    func fetch() -> [Student]{
        let fetchStatementString = "SELECT * FROM student;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let spid = Int(sqlite3_column_int(fetchStatement, 0))
                let sname = String(cString: sqlite3_column_text(fetchStatement, 1))
                let sclass = String(cString: sqlite3_column_text(fetchStatement, 2))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 3))
                let password = String(cString: sqlite3_column_text(fetchStatement, 4))
                
                stud.append(Student(spid: spid, sname: sname ,sclass: sclass, phone: phone, password: password))
                print("\(spid) |  \(sname)  |  \(sclass)  |  \(phone) | \(password)")
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }
    
    func fetchClass() -> [Student]{
        let fetchStatementString = "SELECT * FROM student GROUP BY sclass;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let spid = Int(sqlite3_column_int(fetchStatement, 0))
                let sname = String(cString: sqlite3_column_text(fetchStatement, 1))
                let sclass = String(cString: sqlite3_column_text(fetchStatement, 2))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 3))
                let password = String(cString: sqlite3_column_text(fetchStatement, 4))
                
                stud.append(Student(spid: spid, sname: sname ,sclass: sclass, phone: phone, password: password))
                print("\(sclass)")
                
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        return stud
    }
    
    
    func studClassWise(for sclass:String, completion: @escaping ((Bool) -> Void)) -> [Student] {
        
        let fetchStatementString = "SELECT * FROM student WHERE sclass = ?;"
        var fetchStatement:OpaquePointer? = nil
        var stud = [Student]()

        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Binding Data
            sqlite3_bind_text(fetchStatement, 1, (sclass as NSString).utf8String, -1, nil)
            
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetched class stud succesfully")
                let spid = Int(sqlite3_column_int(fetchStatement, 0))
                let sname = String(cString: sqlite3_column_text(fetchStatement, 1))
                let sclass = String(cString: sqlite3_column_text(fetchStatement, 2))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 3))
                let password = String(cString: sqlite3_column_text(fetchStatement, 4))
                
                stud.append(Student(spid: spid, sname: sname ,sclass: sclass, phone: phone, password: password))
                print("\(spid) |  \(sname)  |  \(sclass)  |  \(phone) | \(password)")
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }
    
    func createTableNotice() {
        //Sql statement
        let createTableString = """
        CREATE TABLE IF NOT EXISTS notice(
        nid INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT
        );
        """
        
        //statement handle
        var createTableStatement:OpaquePointer? = nil
        
        //prepare Statement
        if sqlite3_prepare_v2(db, createTableString, -1 , &createTableStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("notice table created")
            } else {
                print("notice table could not be prepared")
            }
        }
        else
        {
            print("notice table could not be prepared")
        }
        
        //delete statement
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insertNotice(no:Notice, completion: @escaping ((Bool) -> Void)) {
        let insertStatementString = "INSERT INTO notice(title, description) VALUES(?, ?);"
        
        var insertStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, insertStatementString, -1 ,&insertStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(insertStatement, 1, (no.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (no.description as NSString).utf8String, -1, nil)
            
            //Evaluate statement
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("inserted notice row succesfully")
                completion(true)
            } else {
                print("could not insert notice row")
                completion(false)
            }
            
        }
        else
        {
            print("insert notice statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(insertStatement)
        
    }
    
    func updateNotice(no:Notice, completion: @escaping ((Bool) -> Void)) {
        let updateStatementString = "UPDATE notice SET title = ?, description = ? WHERE nid = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, updateStatementString, -1 ,&updateStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(updateStatement, 1, (no.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (no.description as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 3, Int32(no.nid))
            
            //Evaluate statement
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("updated row succesfully")
                completion(true)
            } else {
                print("could not update row")
                completion(false)
            }
            
        }
        else
        {
            print("UPDATE statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(updateStatement)
        
    }
    
    func deleteNotice(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deleteStatementString = "DELETE FROM notice WHERE nid = ?;"
        
        var deleteStatement:OpaquePointer? = nil
        
        //prepare deleteStatement
        if sqlite3_prepare_v2(db, deleteStatementString, -1 ,&deleteStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            //Evaluate statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("deleted notice row succesfully")
                completion(true)
            } else {
                print("could not delete notice row")
                completion(false)
            }
            
        }
        else
        {
            print("Delete notice statement could not be prepared")
            completion(false)
        }
        
        //delete deletestatement
        sqlite3_finalize(deleteStatement)
        
    }
    
    func fetchNotice() -> [Notice]{
        let fetchStatementString = "SELECT * FROM notice;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Notice]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let nid = Int(sqlite3_column_int(fetchStatement, 0))
                let title = String(cString: sqlite3_column_text(fetchStatement, 1))
                let description = String(cString: sqlite3_column_text(fetchStatement, 2))
                
                
                stud.append(Notice(nid: nid, title: title ,description: description))
                print("\(nid) |  \(title)  |  \(description)")
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }
    
    func StudLoginChk(for spid:Int,password:String)->Bool{
        
        let fetchStatementString = "SELECT * FROM student WHERE spid = ? and password = ?;"
        var fetchStatement:OpaquePointer? = nil
     
         var b:Bool = false
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_int(fetchStatement, 1, Int32(spid))
            sqlite3_bind_text(fetchStatement, 2, (password as NSString).utf8String, -1, nil)
            
            //Evaluate statement
            if sqlite3_step(fetchStatement) == SQLITE_ROW
            {
                b = true
            }
        }
        else
        {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("select into :: could not be prepared::\(errmsg)")
            b = false
            print("chklogin fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return b
    }
    
   
    func fetchStudDetail(for id:Int) -> Student{
        let fetchStatementString = "SELECT * FROM student WHERE spid = ?;"
        var fetchStatement:OpaquePointer? = nil
        var stud :Student = Student()
        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil) == SQLITE_OK{
            
            print("in prepare")
            sqlite3_bind_int(fetchStatement, 1, Int32(id))
            
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetched row Successfully")
                
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let name = String(cString:  sqlite3_column_text(fetchStatement, 1))
                let Class = String(cString: sqlite3_column_text(fetchStatement, 2))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 3))
                let pwd = String(cString: sqlite3_column_text(fetchStatement, 4))
              
                stud = Student(spid: id, sname: name, sclass: Class, phone: phone, password: pwd )
                
                //return s1
                print("from helper:  \(id) | \(name) | \(Class) | \(phone) | \(pwd) ")
            }
        }else{
            print("fetch statement could not be prepared")
        }
        sqlite3_finalize(fetchStatement)
        return stud
        
    }
}
