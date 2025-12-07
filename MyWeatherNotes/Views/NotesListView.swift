//
//  NotesListView.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import SwiftUI

struct NotesListView: View {
    @StateObject private var viewModel = NotesListViewModel()
    @State private var isShowingAddSheet = false
    @State private var showingStats = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.notes.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "cloud.sun")
                            .font(.system(size: 70))
                            .foregroundColor(.blue.opacity(0.6))
                        Text("Поки що немає заміток")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        Text("Натисніть + щоб додати")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(viewModel.filteredNotes) { note in
                            NavigationLink(destination: NoteDetailView(note: note)) {
                                NoteRowView(note: note)
                            }
                        }
                        .onDelete(perform: deleteNotes)
                    }
                    .listStyle(.plain)
                }
                
                if viewModel.isLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .overlay(
                            ProgressView()
                                .scaleEffect(1.5)
                                .tint(.white)
                        )
                }
            }
            .navigationTitle("Мої замітки")
            .searchable(text: $viewModel.searchText, prompt: "Пошук заміток")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingStats = true
                    } label: {
                        Image(systemName: "chart.bar.fill")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                AddNoteView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingStats) {
                StatsView(notes: viewModel.notes)
            }
            .alert("Помилка", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Зрозуміло") {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        viewModel.deleteNote(at: offsets)
    }
}
