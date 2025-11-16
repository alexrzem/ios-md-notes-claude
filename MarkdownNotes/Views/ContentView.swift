//
//  ContentView.swift
//  MarkdownNotes
//
//  Main view that adapts to iPhone and iPad layouts
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var notesManager: NotesManager
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var showingSidebar = true

    var body: some View {
        NavigationView {
            // Sidebar with notes list (shown on iPad, hidden on iPhone)
            NotesListView()
                .frame(minWidth: 250, idealWidth: 300)
                .background(AtomOneDark.sidebarBackground)

            // Main editor view
            if let currentNote = notesManager.currentNote {
                MarkdownEditorView(note: currentNote)
            } else {
                EmptyStateView()
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .accentColor(AtomOneDark.blue)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text")
                .font(.system(size: 60))
                .foregroundColor(AtomOneDark.comment)

            Text("No note selected")
                .font(.title2)
                .foregroundColor(AtomOneDark.foreground)

            Text("Select a note from the sidebar or create a new one")
                .font(.body)
                .foregroundColor(AtomOneDark.comment)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AtomOneDark.background)
    }
}
