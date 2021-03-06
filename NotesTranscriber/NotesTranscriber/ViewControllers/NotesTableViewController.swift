//
//  NotesTableViewController.swift
//  NotesTranscriber
//
//  Created by Dongwoo Pae on 12/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController, NoteTableViewCellDelegate {
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteTableViewCell
        let note = self.noteController.notes[indexPath.row]
        cell.note = note
        cell.delegate = self
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
        if segue.identifier == "ToAddNote" {
            guard let destVC = segue.destination as? TextViewViewController else {return}
            destVC.noteController = self.noteController
        } else if segue.identifier == "ToShowNote" {
            guard let destVC = segue.destination as? TextViewViewController,
                let selectedRow = self.tableView.indexPathForSelectedRow else {return}
            destVC.noteController = self.noteController
            destVC.note = self.noteController.notes[selectedRow.row]
        }
    }
    
    
    func showActivityView(for cell: NoteTableViewCell) {
        guard let noteInput = cell.note?.noteText else {
            print("no text found")
            return
        }
        let vc = UIActivityViewController(activityItems: [noteInput], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
}
