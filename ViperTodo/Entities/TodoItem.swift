//
//  TodoItem.swift
//  ViperTodo
//
//  Created by X on 8.07.2021.
//

import Foundation

class TodoItem {
    var id: UUID
    var title: String
    var content: String
    
    init(id: UUID, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
