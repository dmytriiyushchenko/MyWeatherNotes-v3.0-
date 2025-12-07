//
//  NoteDetailView.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import SwiftUI

struct NoteDetailView: View {
    @StateObject private var viewModel: NoteDetailViewModel
    
    init(note: Note) {
        _viewModel = StateObject(wrappedValue: NoteDetailViewModel(note: note))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Текст")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                    
                    Text(viewModel.note.text)
                        .font(.body)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Дата створення")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        Text(viewModel.formattedDate)
                            .font(.subheadline)
                    }
                }
                
                if let weather = viewModel.note.weather {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Погода")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                        
                        HStack(spacing: 20) {
                            if let url = weather.iconURL {
                                AsyncImage(url: url) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                    } else if phase.error != nil {
                                        Image(systemName: "exclamationmark.cloud")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                    } else {
                                        ProgressView()
                                            .frame(width: 100, height: 100)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(weather.temperatureString)
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Text(weather.description.capitalized)
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    Image(systemName: "location.fill")
                                        .font(.caption)
                                    Text(weather.cityName)
                                        .font(.subheadline)
                                }
                                .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Замітка")
        .navigationBarTitleDisplayMode(.inline)
    }
}
