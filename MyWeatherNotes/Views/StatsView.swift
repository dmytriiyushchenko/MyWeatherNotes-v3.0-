//
//  StatsView.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import SwiftUI

struct StatsView: View {
    let notes: [Note]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("Загальна інформація") {
                    HStack {
                        Text("Всього заміток")
                        Spacer()
                        Text("\(notes.count)")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("З погодою")
                        Spacer()
                        Text("\(notesWithWeather)")
                            .foregroundColor(.secondary)
                    }
                }
                
                if let avgTemp = averageTemperature {
                    Section("Середня температура") {
                        HStack {
                            Image(systemName: "thermometer.medium")
                                .foregroundColor(.orange)
                            Text(String(format: "%.1f°C", avgTemp))
                                .font(.title2)
                                .bold()
                        }
                    }
                }
                
                if let first = oldestNote {
                    Section("Перша замітка") {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(first.text)
                                .font(.body)
                            Text(formattedDate(first.createdAt))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Статистика")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var notesWithWeather: Int {
        notes.filter { $0.weather != nil }.count
    }
    
    private var averageTemperature: Double? {
        let temps = notes.compactMap { $0.weather?.temperature }
        guard !temps.isEmpty else { return nil }
        return temps.reduce(0, +) / Double(temps.count)
    }
    
    private var oldestNote: Note? {
        notes.min(by: { $0.createdAt < $1.createdAt })
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}
