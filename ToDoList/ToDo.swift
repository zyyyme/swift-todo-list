//
//  ToDo.swift
//  ToDoList
//
//  Created by Владислав Левченко on 28.03.2022.
//

import Foundation
import UIKit


struct ToDo: Equatable, Codable {
    let id = UUID()
    var title: String
    var description: String
    var isComplete: Bool
    var dueDate: Date

    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let toDo1 = ToDo(title: "Hello", description: "There", isComplete: false, dueDate: Date())
        let toDo2 = ToDo(title: "There", description: "General", isComplete: false, dueDate: Date())
        let toDo3 = ToDo(title: "General Kenobi", description: "Kenobi", isComplete: false, dueDate: Date())
        
        return [toDo1, toDo2, toDo3]
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
}
