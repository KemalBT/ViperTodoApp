//
//  TodoDetailInteractor.swift
//  ViperTodo
//
//  Created by X on 9.07.2021.
//

import Foundation

class TodoDetailInteractor: TodoDetailInteractorInputProtocol {
    
    weak var presenter: TodoDetailInteractorOutputProtocol?
    var coreDataStore = CoreDataStore.shared
    var todoItem: TodoItem?
    
    func deleteTodo() {
        guard let todoItem = todoItem else { return }
        coreDataStore.removeTodo(todoItem)
        presenter?.didDeleteTodo()
    }
    
    func saveTodo(title: String, content: String) {
        guard let todoItem = todoItem else { return }
        todoItem.title = title
        todoItem.content = content
        
        coreDataStore.saveTodo(todoItem)
        presenter?.didSaveTodo(todoItem)
    }
    
}
