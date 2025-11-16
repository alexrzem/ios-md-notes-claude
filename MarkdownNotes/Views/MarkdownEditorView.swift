//
//  MarkdownEditorView.swift
//  MarkdownNotes
//
//  Markdown text editor with syntax highlighting
//

import SwiftUI

struct MarkdownEditorView: View {
    let note: Note
    @EnvironmentObject var notesManager: NotesManager
    @State private var editableContent: String = ""
    @FocusState private var isEditorFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            // Title bar with note info
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(note.title.isEmpty ? "Untitled Note" : note.title)
                        .font(.system(.headline, design: .monospaced))
                        .foregroundColor(AtomOneDark.foreground)

                    Text("Modified: \(note.modifiedAt.formatted(date: .abbreviated, time: .shortened))")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(AtomOneDark.comment)
                }

                Spacer()

                // Stats
                HStack(spacing: 16) {
                    Label("\(wordCount) words", systemImage: "text.word.spacing")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(AtomOneDark.comment)

                    Label("\(characterCount) chars", systemImage: "textformat.abc")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(AtomOneDark.comment)
                }
            }
            .padding()
            .background(AtomOneDark.tabBackground)

            Divider()
                .background(AtomOneDark.gutter)

            // Main editor
            ZStack(alignment: .topLeading) {
                // Background
                AtomOneDark.background
                    .edgesIgnoringSafeArea(.all)

                // Syntax-highlighted text editor
                MarkdownTextEditor(text: $editableContent)
                    .focused($isEditorFocused)
                    .onChange(of: editableContent) { newValue in
                        notesManager.updateCurrentNote(content: newValue)
                    }
            }
        }
        .onAppear {
            editableContent = note.content
            // Auto-focus on new notes
            if note.content.isEmpty {
                isEditorFocused = true
            }
        }
        .onChange(of: note.id) { _ in
            editableContent = note.content
        }
    }

    private var wordCount: Int {
        let words = editableContent.components(separatedBy: .whitespacesAndNewlines)
        return words.filter { !$0.isEmpty }.count
    }

    private var characterCount: Int {
        editableContent.count
    }
}

struct MarkdownTextEditor: View {
    @Binding var text: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        TextEditor(text: $text)
            .font(.system(.body, design: .monospaced))
            .foregroundColor(AtomOneDark.foreground)
            .scrollContentBackground(.hidden)
            .background(AtomOneDark.background)
            .padding(16)
            // Custom text editing attributes
            .autocorrectionDisabled(false)
            .textInputAutocapitalization(.sentences)
    }
}

// Preview provider
struct MarkdownEditorView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleNote = Note(
            content: """
            # Sample Markdown Note

            This is a **bold** text and this is *italic*.

            ## Code Example

            ```swift
            let message = "Hello, World!"
            print(message)
            ```

            ## List

            - Item 1
            - Item 2
            - Item 3

            ## Links

            [GitHub](https://github.com)
            """
        )

        MarkdownEditorView(note: sampleNote)
            .environmentObject(NotesManager())
    }
}
