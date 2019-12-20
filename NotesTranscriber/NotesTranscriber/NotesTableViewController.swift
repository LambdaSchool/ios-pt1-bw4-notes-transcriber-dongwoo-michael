//
//  NotesTableViewController.swift
//  NotesTranscriber
//
//  Created by Dongwoo Pae on 12/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    let noteController = NoteController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
     override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.tableView.reloadData()
       }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteController.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = self.noteController.notes[indexPath.row]
        cell.textLabel?.text = note.noteText
        
        //Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let dateFromNote = note.timestamp
        let createdDate = dateFormatter.string(from: dateFromNote!)
        dateFormatter.timeZone = NSTimeZone.local
        
        cell.detailTextLabel?.text = createdDate
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = self.noteController.notes[indexPath.row]
            self.noteController.deleteNote(for: note)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddText" {
            guard let destVC = segue.destination as? TextViewViewController else {return}
        
        } else if segue.identifier == "UpdateText" {
            guard let destVC = segue.destination as? TextViewViewController,
                let selectedRow = self.tableView.indexPathForSelectedRow else {return}
            
        }
    }
}
