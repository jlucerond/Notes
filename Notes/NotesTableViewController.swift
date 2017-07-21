//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Joe Lucero on 7/21/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if isEditing {
            tableView.setEditing(false, animated: true)
            editButton.title = "Edit"
            isEditing = false
        } else {
            tableView.setEditing(true, animated: true)
            editButton.title = "Done"
            isEditing = true
        }
    }
}

// MARK: - Table view data source
extension NotesTableViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return NotesController.shared.arrayOfNotes.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = NotesController.shared.arrayOfNotes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = note.text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = NotesController.shared.arrayOfNotes[indexPath.row]
            NotesController.shared.delete(note: noteToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt fromIndexPath: IndexPath,
                            to: IndexPath) {
        NotesController.shared.moveNote(from: fromIndexPath.row, to: to.row)
    }
    
}

// MARK: - Navigation
extension NotesTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let notesDetailViewController = segue.destination as? NotesDetailViewController else {
            return
        }
        
        if segue.identifier == "editNote" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            notesDetailViewController.title = "Edit Note"
            let noteToEdit = NotesController.shared.arrayOfNotes[indexPath.row]
            notesDetailViewController.note = noteToEdit
            
        } else if segue.identifier == "addNote" {
            notesDetailViewController.title = "New Note"
        }
    }
}











