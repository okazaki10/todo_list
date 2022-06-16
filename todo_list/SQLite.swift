//
//  SQLite.swift
//  todo_list
//
//  Created by Rakha A on 16/06/22.
//

import Foundation
import SQLite

class SQLite{
    var db:Connection?
    var initiate=false
    init(){
        print("berhasil")
        if(initiate==false){
            openDatabase()
            createTable()
            initiate=true
        }
    
    }
    
    func deleteTable(){
        do{
            try db!.execute("""
                
                DROP TABLE todo
                
                """
            )
        }catch{
            print(error)
        }
    }
    func openDatabase() {
        // Wrap everything in a do...catch to handle errors
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/db.sqlite3")
        }catch{
            print(error)
        }
        
    }
    
    func createTable(){
        
        do{
            try db!.execute("""

                CREATE TABLE IF NOT EXISTS todo (
                    id INTEGER PRIMARY KEY NOT NULL,
                    title TEXT,
                    subtitle TEXT,
                    task TEXT
                );

                """
            )
        }catch{
            print(error)
        }

    }
    
    func insertTodoList(title:String,subTitle:String,task:String){
        do{
        let stmt = try db!.run("INSERT INTO todo (id,title,subtitle,task) VALUES (?,?,?,?)",nil,title,subTitle,task)
            print(stmt)
        }catch{
            print(error)
        }
    }
    
    func getTodoList()->Statement?{
        var stmt:Statement?
        do{
            stmt = try db!.prepare("SELECT * FROM todo ORDER BY id DESC")
            return stmt
        }catch{
            print(error)
            return stmt
        }
    }
    
    func deleteTodoList(id:Int64){
        do{
        let stmt = try db!.run("DELETE FROM todo WHERE id = ?",id)
        print(stmt)
        }catch{
            print(error)
        }
    }

}
