//
//  NotesListView.swift
//  MarkdownNotes
//
//  Sidebar view displaying list of all notes
//

import SwiftUI

struct NotesListView: View {
    @EnvironmentObject var notesManager: NotesManager
    @State private var searchText = ""

    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notesManager.notes
        } else {
            return notesManager.notes.filter { note in
                note.title.localizedCaseInsensitiveContains(searchText) ||
                note.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header with new note button
            HStack {
                Text("Notes")
                    .font(.title2.bold())
                    .foregroundColor(AtomOneDark.foreground)

                Spacer()

                Button(action: {
                    notesManager.createNewNote()
                }) {
                    Image(systemName: "square.and.pencil")
                        .font(.title3)
                        .foregroundColor(AtomOneDark.blue)
                }
            }
            .padding()
            .background(AtomOneDark.sidebarBackground)

            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(AtomOneDark.comment)

                TextField("Search notes...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(AtomOneDark.foreground)

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(AtomOneDark.comment)
                    }
                }
            }
            .padding(8)
            .background(AtomOneDark.background)
            .cornerRadius(6)
            .padding(.horizontal)
            .padding(.bottom, 8)

            // Notes list
            List {
                ForEach(filteredNotes) { note in
                    NoteRowView(note: note)
                        .listRowBackground(
                            notesManager.currentNote?.id == note.id ?
                            AtomOneDark.selection : Color.clear
                        )
                        .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .onTapGesture {
                            notesManager.selectNote(note)
                        }
                }
                .onDelete(perform: deleteNotes)
            }
            .listStyle(PlainListStyle())
            .background(AtomOneDark.sidebarBackground)
        }
        .background(AtomOneDark.sidebarBackground)
    }

    private func deleteNotes(at offsets: IndexSet) {
        for index in offsets {
            let note = filteredNotes[index]
            notesManager.deleteNote(note)
        }
    }
}

struct NoteRowView: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(AtomOneDark.foreground)
                .lineLimit(1)

            Text(note.formattedDate)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(AtomOneDark.comment)

            if !note.content.isEmpty {
                Text(note.content)
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundColor(AtomOneDark.sidebarForeground)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}
