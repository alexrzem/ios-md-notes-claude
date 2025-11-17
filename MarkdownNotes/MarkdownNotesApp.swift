//
//  MarkdownNotesApp.swift
//  MarkdownNotes
//
//  A Markdown-based notes app styled like VS Code with Atom One Dark theme
//

import SwiftUI

@main
struct MarkdownNotesApp: App {
    @StateObject private var notesManager = NotesManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notesManager)
                .preferredColorScheme(.dark)
        }
    }
}
