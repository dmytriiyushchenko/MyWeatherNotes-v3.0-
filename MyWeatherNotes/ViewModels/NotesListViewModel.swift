//
//  NotesListViewModel.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import Foundation
import Combine

class NotesListViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private let storageService = StorageService()
    private let weatherService = WeatherService()
    
    init() {
        loadNotes()
    }
    
    func loadNotes() {
        notes = storageService.loadNotes().sorted { $0.createdAt > $1.createdAt }
    }
    
    func addNote(text: String) {
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let weather):
                    let note = Note(text: text, weather: weather)
                    self?.notes.insert(note, at: 0)
                    self?.saveNotes()
                    
                case .failure(_):
                    self?.errorMessage = "Не вдалося завантажити погоду"
                    let note = Note(text: text, weather: nil)
                    self?.notes.insert(note, at: 0)
                    self?.saveNotes()
                }
            }
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }
    
    func saveNotes() {
        storageService.saveNotes(notes)
    }
    
    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notes
        }
        return notes.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
    }
}
