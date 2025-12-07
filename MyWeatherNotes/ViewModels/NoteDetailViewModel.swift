//
//  NoteDetailViewModel.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import Foundation

class NoteDetailViewModel: ObservableObject {
    @Published var note: Note
    
    init(note: Note) {
        self.note = note
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "uk_UA")
        return formatter.string(from: note.createdAt)
    }
}
