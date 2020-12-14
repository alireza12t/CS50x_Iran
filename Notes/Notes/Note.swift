//
//  Note.swift
//  Notes
//
//  Created by ali on 12/1/20.
//

import Foundation
import SQLite3

struct Note {
    var id: Int
    var contents: String
}


class NoteManager {
    
    
    var database: OpaquePointer!
    
    static let shared = NoteManager()
    
    private init() {}
    
    func create() -> Int{
        connect()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "INSERT INTO notes (contents) VALUES ('New note')", -1, &statement, nil) != SQLITE_OK {
            print("Could Not insert in table")
            return -1
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Fail to insert")
            return -1
        }
        
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
    }
    
    
    func getAllNotes() -> [Note] {
        connect()
        var results = [Note]()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "SELECT rowid, contents FROM notes", -1, &statement, nil) != SQLITE_OK {
            print("Failed to create query")
            return []
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            results.append(Note(id: Int(sqlite3_column_int(statement, 0)), contents: String(cString: sqlite3_column_text(statement, 1))))
        }
        
        sqlite3_finalize(statement)
        
        return results
    }
    
    
    func connect(){
        if database != nil {
            return
        }
        
        do {
        let dataBaseUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("notes2.sqlite3")
            if sqlite3_open(dataBaseUrl.path, &database) == SQLITE_OK {
                if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS  notes (contents TEXT)", nil, nil, nil) == SQLITE_OK {
                    
                } else {
                    print("Could not create Table")
                }
            } else {
                print("Could not create Database")
            }
            
        } catch let error {
            print("\(error)")
        }
    }
    
    
    func save(note: Note) {
        connect()
        
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "UPDATE notes SET contents = ? WHERE rowid = ?", -1, &statement, nil) != SQLITE_OK {
            print("Failed to load Query")
            return
        }
        
        sqlite3_bind_text(statement, 1, NSString(string: note.contents).utf8String, -1, nil)
        sqlite3_bind_int(statement, 2, Int32(note.id))
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Error in update")
        }
        
        sqlite3_finalize(statement)
        
    }
}
