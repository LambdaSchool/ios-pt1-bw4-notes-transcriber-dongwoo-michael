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
    
    init() {reloadFromPersistentStore()}
    //CRUD
    //create note
    func createNote(for noteText: String) {
        let note = Note(noteText: noteText)
        self.notes.append(note)
        saveToPersistentStore()
    }
    
    //update note
    func updateNote(for note: Note, noteText: String) {
        guard let index = self.notes.firstIndex(of: note) else {return}
        self.notes[index].noteText = noteText
        saveToPersistentStore()
    }
    
    //delete note
    func deleteNote(for note: Note) {
        guard let index = self.notes.firstIndex(of: note) else {return}
        self.notes.remove(at: index)
        saveToPersistentStore()
    }
    
    
    // MARK: Basic Persistent
    //create a file
    private var notesURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectory.appendingPathComponent("Notes.plist")
    }
    
    //save it to location(file)
    func saveToPersistentStore() {
        guard let url = notesURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let notesData = try encoder.encode(notes)
            try notesData.write(to: url)
        } catch {
            NSLog("error saving notes data: \(error)")
        }
    }
    
    
    //reload it from location (file)
    func reloadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = notesURL,
            fileManager.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedNotes = try decoder.decode([Note].self, from: data)
            self.notes = decodedNotes
        } catch {
            NSLog("error loading notes data:\(error)")
        }
    }
    
}
