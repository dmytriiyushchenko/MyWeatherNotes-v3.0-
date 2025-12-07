//
//  NoteRowView.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import SwiftUI

struct NoteRowView: View {
    let note: Note
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 6) {
                Text(note.text)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineLimit(3)
                    .foregroundColor(.primary)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text(getDateString())
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if let weather = note.weather {
                VStack(spacing: 6) {
                    if let url = weather.iconURL {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            case .failure(_):
                                Image(systemName: "cloud.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            case .empty:
                                ProgressView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    Text(weather.temperatureString)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: note.createdAt)
    }
}
