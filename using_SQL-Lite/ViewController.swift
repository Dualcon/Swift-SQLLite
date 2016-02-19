//
//  ViewController.swift
//  using_SQL-Lite
//
//  Created by Daniel Vieira on 27/11/14.
//  Copyright (c) 2014 Daniel Vieira. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
// Create a file manager
        let fileManager = NSFileManager.defaultManager()
        // Define tipo de diretoria e para que domínio, e sem máscara (devolve todos os domínios)
        let dirs: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        if (dirs != nil) {
            // wrap dirs array
            let diretorias:[String] = dirs!
            // first position has path string
            let path = diretorias[0]
// show path
            println(path)
            // Create database file name
            let nomeFicheiro = "db.sqlite3"
            // concat path with database file name
            let pathTotal = path.stringByAppendingPathComponent(nomeFicheiro)
//            println(pathTotal)

            let id = Expression<Int>("id")
            let name = Expression<String?>("name")
            let email = Expression<String>("email")

            // Check if database already exists
            if (!fileManager.fileExistsAtPath(pathTotal)) {
                // Create database connection
                let db = Database(pathTotal)
                let users = db["users"]
                
                // CREATE TABLE "users" (
            db.create(table: users) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email, unique: true)
            }
}
            
            // Create database connection
            let db = Database(pathTotal)
            // Create database user
            let users = db["users"]
            var alice: Query?

            // inserted id: 1
            // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
            if let insertedID = users.insert(name <- "Alice", email <- "alice@mac.com") {
                println("inserted id: \(insertedID)")
                alice = users.filter(id == insertedID)
            }
// Another insert
            if let insertedID = users.insert(name <- "Daniel", email <- "daniel@mac.com") {
                println("inserted id: \(insertedID)")
                alice = users.filter(id == insertedID)
            }

            // SELECT * FROM "users"
            for user in users {
                println("id: \(user[id]), name: \(user[name]), email: \(user[email])")
            }

            // UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
            // WHERE ("id" = 1)
            alice?.update(email <- replace(email, "mac.com", "me.com"))?

            // DELETE FROM "users" WHERE ("id" = 1)
            alice?.delete()?
            alice?.delete(NSString.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
