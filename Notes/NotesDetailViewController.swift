//
//  NotesDetailViewController.swift
//  Notes
//
//  Created by Joe Lucero on 7/21/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController {
    
    var note: Note?
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = note {
            textView.text = note.text
        } else {
            textView.text = ""
        }

        textView.becomeFirstResponder()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let note = note {
            // note already exists, update the note
            NotesController.shared.update(note: note, withNewText: textView.text)
        } else {
            // note does not exist, create a new note
            NotesController.shared.createNoteWith(text: textView.text)
        }
        navigationController?.popViewController(animated: true)
    }

}
