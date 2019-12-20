//
//  NoteController.swift
//  NotesTranscriber
//
//  Created by Dongwoo Pae on 12/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NoteController {
    
    var notes: [Note] = []
    //CRUD
    //create note
    func createNote(for noteText: String) {
        let note = Note(noteText: noteText)
        self.notes.append(note)
    }
    
    //update note
    func updateNote(for note: Note, noteText: String) {
        guard let index = self.notes.firstIndex(of: note) else {return}
        self.notes[index].noteText = noteText
    }
    
    //delete note
    func deleteNote(for note: Note) {
        guard let index = self.notes.firstIndex(of: note) else {return}
        self.notes.remove(at: index)
    }
}
