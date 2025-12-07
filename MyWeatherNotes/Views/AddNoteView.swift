//
//  AddNoteView.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: NotesListViewModel
    @State private var text = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Що сталося?")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top)
                
                TextEditor(text: $text)
                    .focused($isTextFieldFocused)
                    .frame(minHeight: 150)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray6))
                    )
                    .padding(.horizontal)
                
                HStack {
                    Image(systemName: "cloud.fill")
                        .foregroundColor(.blue)
                    Text("Погода додасться автоматично")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Додати замітку")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Відміна") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        saveNote()
                    }
                    .disabled(isTextEmpty)
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                isTextFieldFocused = true
            }
        }
    }
    
    private var isTextEmpty: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func saveNote() {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        viewModel.addNote(text: trimmedText)
        dismiss()
    }
}
