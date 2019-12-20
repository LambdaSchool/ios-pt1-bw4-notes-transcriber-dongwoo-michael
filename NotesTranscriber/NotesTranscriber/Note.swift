//
//  Note.swift
//  NotesTranscriber
//
//  Created by Dongwoo Pae on 12/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

struct Note: Equatable {
    var noteText: String
    let timestamp: Date?
    
    init(noteText: String, timestamp: Date = Date()) {
        self.noteText = noteText
        self.timestamp = timestamp
    }
}
