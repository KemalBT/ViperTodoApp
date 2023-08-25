//
//  TodoListProtocol.swift
//  ViperTodo
//
//  Created by X on 8.07.2021.
//

import Foundation

// Presenter -> View
protocol TodoListViewProtocol: AnyObject {
    var presenter: TodoListPresenterProtocol? { get set }
    func showTodos(_ todos: [TodoItem])
}

// View -> Presenter
protocol TodoListPresenterProtocol: AnyObject {
    
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    
    func viewWillAppear()
    func newTodo()
    func showTodoDetail(_ Todo: TodoItem)
    func removeTodo(_ todo: TodoItem)
}

// Presenter -> Interactor
protocol TodoListInteractorInputProtocol: AnyObject {
    var presenter: TodoListInteractorOutputProtocol? { get set }
    
    func retrieveTodos()
    func deleteTodo(_ todo: TodoItem)
}

// Interactor -> Presenter
protocol TodoListInteractorOutputProtocol: AnyObject {
    func didSaveTodo(_ todo: TodoItem)
    func didRemoveTodo(_ todo: TodoItem)
    func didRetrieveTodos(_ todos: [TodoItem])
}

// Presenter -> Router
protocol TodoListRouterProtocol: AnyObject {
    func presentToDoDetailScreen(from view: TodoListViewProtocol, for todo: TodoItem?)
}
