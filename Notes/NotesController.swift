//
//  NotesController.swift
//  Notes
//
//  Created by Joe Lucero on 7/21/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import Foundation

class NotesController {
    fileprivate static let arrayOfNotesKey = "arrayOfNotesKey"
    static let shared = NotesController()
    var arrayOfNotes: [Note] = []
    
    init() {
        loadData()
    }
    
    // Notes Controller CRUD Functions
    /// Creates a new note
    func createNoteWith(text: String) {
        let newNote = Note(text: text)
        arrayOfNotes.append(newNote)
        saveData()
    }
    
    /// Returns an array of notes that include the selected text
    func searchForNotesWith(text: String) -> [Note] {
        
        return arrayOfNotes.filter{$0.containsText(text: text)}
    }
    
    /// Updates an existing note
    func update(note: Note, withNewText text: String){
        guard let index = arrayOfNotes.index(of: note),
        index < arrayOfNotes.count else {
            return
        }
        
        // it's probably easier to just make a new note, but I did this as is in case future functionality made the notes more distinctive
        var newNote = note
        newNote.text = text
        
        arrayOfNotes[index] = newNote
        saveData()
    }
    
    /// Reorders the shared instance of an array of notes on the main screen
    func moveNote(from oldRow: Int, to newRow: Int) {
        let noteToReorder = arrayOfNotes[oldRow]
        arrayOfNotes.remove(at: oldRow)
        arrayOfNotes.insert(noteToReorder, at: newRow)
        saveData()
    }
    
    // Delete a note
    func delete(note: Note) {
        guard let index = arrayOfNotes.index(of: note),
            index < arrayOfNotes.count else {
            return
        }
        
        arrayOfNotes.remove(at: index)
        saveData()
    }
}

// FIXME: - In this file, does it matter whether I use the arrayOfNotes or the shared instance of an arrayOfNotes???

extension NotesController {
    fileprivate func saveData() {
        let notesInDictionaryFormat: [[String : String]] = arrayOfNotes.map{$0.dictionaryRepresentation}
        
        UserDefaults.standard.set(notesInDictionaryFormat, forKey: NotesController.arrayOfNotesKey)
    }
    
    fileprivate func loadData() {
        guard let notesInDictionaryFormat = UserDefaults.standard.array(forKey: NotesController.arrayOfNotesKey) as? [[String : String]] else {
            return
        }

        arrayOfNotes = notesInDictionaryFormat.flatMap{ Note(dictionary: $0) }
    }

}








