//
//  Note.swift
//  MarkdownNotes
//
//  Data model for individual notes
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var content: String
    var createdAt: Date
    var modifiedAt: Date

    var title: String {
        // Extract first line or use date as title
        let firstLine = content.components(separatedBy: .newlines).first ?? ""
        let cleanTitle = firstLine.trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: "#", with: "")
            .trimmingCharacters(in: .whitespaces)

        if cleanTitle.isEmpty {
            return formattedDate
        }
        return cleanTitle
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: createdAt)
    }

    var fileName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HHmmss"
        return formatter.string(from: createdAt)
    }

    init(id: UUID = UUID(), content: String = "", createdAt: Date = Date(), modifiedAt: Date = Date()) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
