//
//  ViewController.swift
//  Notes
//
//  Created by ali on 12/1/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes: [Note] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].contents
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteSegue" {
            if let vc = segue.destination as? NoteViewContoller {
                guard let index = tableView.indexPathForSelectedRow?.row else {
                    print("Invalid cell selected")
                    return
                }
                vc.note = notes[index]
            }
        }
    }
    
    @IBAction func addNewNoteButtonDidTap(_ sender: Any) {
        let _ = NoteManager.shared.create()
        reload()
    }
    
    
    func reload(){
        notes = NoteManager.shared.getAllNotes()
        tableView.reloadData()
    }
}

