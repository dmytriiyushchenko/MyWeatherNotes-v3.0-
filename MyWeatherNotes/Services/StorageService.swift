//
//  StorageService.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import Foundation

class StorageService {
    private let notesKey = "savedNotes"
    
    func saveNotes(_ notes: [Note]) {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
    }
    
    func loadNotes() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: notesKey),
              let notes = try? JSONDecoder().decode([Note].self, from: data) else {
            return []
        }
        return notes
    }
}
