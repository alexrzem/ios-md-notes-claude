//
//  NotesManager.swift
//  MarkdownNotes
//
//  Manages note creation, storage, and auto-save functionality
//

import Foundation
import Combine

class NotesManager: ObservableObject {
    @Published var notes: [Note] = []
    @Published var currentNote: Note?

    private let saveKey = "SavedNotes"
    private var cancellables = Set<AnyCancellable>()
    private var autoSaveTimer: Timer?

    init() {
        loadNotes()
        setupAutoSave()
    }

    func createNewNote() {
        let newNote = Note()
        notes.insert(newNote, at: 0)
        currentNote = newNote
        saveNotes()
    }

    func updateCurrentNote(content: String) {
        guard var note = currentNote else { return }
        note.content = content
        note.modifiedAt = Date()

        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            currentNote = note
        }

        // Auto-save after content update
        scheduleAutoSave()
    }

    func deleteNote(_ note: Note) {
        notes.removeAll { $0.id == note.id }
        if currentNote?.id == note.id {
            currentNote = notes.first
        }
        saveNotes()
    }

    func selectNote(_ note: Note) {
        currentNote = note
    }

    private func setupAutoSave() {
        // Auto-save every 2 seconds when typing
        autoSaveTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.saveNotes()
        }
    }

    private func scheduleAutoSave() {
        // Save will happen on next timer tick
    }

    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    private func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decoded.sorted { $0.modifiedAt > $1.modifiedAt }
            currentNote = notes.first
        } else {
            // Create initial blank note on first launch
            createNewNote()
        }
    }
}
