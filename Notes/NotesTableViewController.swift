//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Joe Lucero on 7/21/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    var arrayToUse: [Note] {
        guard let text = searchButtonTextField.text else {
            return NotesController.shared.arrayOfNotes
        }
        
        if text.isEmpty {
            return NotesController.shared.arrayOfNotes
        } else {
            return searchedArray
        }
            
    }
    
    var searchedArray: [Note] {
        guard let text = searchButtonTextField.text else {
            return []
        }
        return NotesController.shared.searchForNotesWith(text: text)
    }
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var searchButtonTextField: UITextField!
    
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
    @IBAction func searchButtonWasTyped(_ sender: UITextField) {
        
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension NotesTableViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return arrayToUse.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = arrayToUse[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = note.text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = arrayToUse[indexPath.row]
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
            let noteToEdit = arrayToUse[indexPath.row]
            notesDetailViewController.note = noteToEdit
            
        } else if segue.identifier == "addNote" {
            notesDetailViewController.title = "New Note"
        }
    }
}






