//
//  TodoListPresenter.swift
//  ViperTodo
//
//  Created by X on 8.07.2021.
//

import Foundation

class TodoListPresenter: TodoListPresenterProtocol {
    
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    var router: TodoListRouterProtocol?
        
    func showTodoDetail(_ Todo: TodoItem) {
        guard let view = view else { return }
        router?.presentToDoDetailScreen(from: view, for: Todo)
    }
    
    //List all todos when launch
    func viewWillAppear() {
        interactor?.retrieveTodos()
    }
    
    //Remove a todo
    func removeTodo(_ todo: TodoItem) {
        interactor?.deleteTodo(todo)
    }
    
    //Insert new todo
    func newTodo() {
        guard let view = view else { return }
        router?.presentToDoDetailScreen(from: view, for: nil)
    }
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    //Callback for successfully saved object
    func didSaveTodo(_ todo: TodoItem) {
        interactor?.retrieveTodos()
    }
    
    //Trigger for UI
    func didRetrieveTodos(_ todos: [TodoItem]) {
        view?.showTodos(todos)
    }
    
    //Callback for deleted object
    func didRemoveTodo(_ todo: TodoItem) {
        interactor?.retrieveTodos()
    }
}
