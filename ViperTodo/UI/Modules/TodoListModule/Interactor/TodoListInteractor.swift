//
//  TodoListInteractor.swift
//  ViperTodo
//
//  Created by X on 8.07.2021.
//

import Foundation

class TodoListInteractor: TodoListInteractorInputProtocol {
    
    //Declaration for outgoing notification to presenter
    weak var presenter: TodoListInteractorOutputProtocol?
    
    //Data Store
    var coreDataStore = CoreDataStore.shared
    
    func retrieveTodos() {
        var fetchedTodos: [TodoItem] {
            return coreDataStore.getAllTodos()
        }
        
        //Trigger notification to presenter
        presenter?.didRetrieveTodos(fetchedTodos)
    }
    
    func saveTodo(_ todo: TodoItem) {
        coreDataStore.saveTodo(todo)
        presenter?.didSaveTodo(todo)
    }
        
    func deleteTodo(_ todo: TodoItem) {
        coreDataStore.removeTodo(todo)
        presenter?.didRemoveTodo(todo)
    }
}
