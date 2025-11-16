# Markdown Notes

A beautiful iOS notes application that uses Markdown syntax instead of a WYSIWYG editor. Styled after Microsoft's VS Code with the Atom One Dark color scheme.

## Features

- **Markdown Syntax Support**: Write notes using Markdown syntax for formatting
- **VS Code Styling**: Dark theme inspired by Atom One Dark color scheme
- **Universal App**: Optimized for both iPhone and iPad
- **Auto-Save**: Notes automatically save as you type
- **Date-Based Naming**: Notes are automatically titled with creation date and time
- **Search**: Quick search through all your notes
- **Clean Interface**: Minimal, distraction-free writing experience

## Requirements

- iOS 16.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## Installation

1. Clone this repository
2. Open `MarkdownNotes.xcodeproj` in Xcode
3. Select your target device (iPhone or iPad simulator)
4. Build and run the project (Cmd+R)

## Usage

### Creating Notes
- Tap the "+" button in the sidebar to create a new note
- Start typing using Markdown syntax
- Notes are automatically saved as you type

### Markdown Syntax Examples

```markdown
# Heading 1
## Heading 2
### Heading 3

**Bold text**
*Italic text*

- List item 1
- List item 2

1. Numbered item 1
2. Numbered item 2

[Link text](https://example.com)

`inline code`

​```
code block
​```
```

### iPad Features
- Split-view interface with notes list on the left
- Full-screen editor on the right
- Swipe to delete notes

### iPhone Features
- Navigation-based interface
- Tap notes to edit
- Swipe to delete notes

## Color Scheme

The app uses the Atom One Dark color scheme from VS Code:

- Background: `#282C34`
- Foreground: `#ABB2BF`
- Sidebar: `#21252B`
- Comments: `#5C6370`
- Syntax Colors: Red, Orange, Yellow, Green, Cyan, Blue, Purple

## Architecture

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive state management
- **UserDefaults**: Local data persistence
- **MVVM Pattern**: Clean separation of concerns

## File Structure

```
MarkdownNotes/
├── MarkdownNotesApp.swift      # App entry point
├── Models/
│   ├── Note.swift              # Note data model
│   └── NotesManager.swift      # Note management logic
├── Views/
│   ├── ContentView.swift       # Main container view
│   ├── NotesListView.swift     # Sidebar notes list
│   └── MarkdownEditorView.swift # Markdown editor
└── Utilities/
    └── AtomOneDark.swift       # Color scheme definitions
```

## Future Enhancements

- [ ] iCloud sync
- [ ] Export to PDF/HTML
- [ ] Enhanced syntax highlighting
- [ ] Custom themes
- [ ] Tags and categories
- [ ] Markdown preview mode
- [ ] File attachments

## License

MIT License - feel free to use this project however you'd like!

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
