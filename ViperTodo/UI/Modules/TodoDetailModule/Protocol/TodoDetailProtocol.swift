//
//  TodoDetailRouter.swift
//  ViperTodo
//
//  Created by X on 9.07.2021.
//

import UIKit

// Presenter -> View
protocol TodoDetailViewProtocol: AnyObject {
    var presenter: TodoDetailPresenterProtocol? { get set }
    
    func showTodo(_ todo: TodoItem)
    func successfullySaveCallback(_ todo: TodoItem)
}

// View -> Presenter
protocol TodoDetailPresenterProtocol: AnyObject {
    var view: TodoDetailViewProtocol? { get set }
    var interactor: TodoDetailInteractorInputProtocol? { get set }
    var router: TodoDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func deleteTodo()
    func saveTodo(title: String, content: String)
}

// Presenter -> Interactor
protocol TodoDetailInteractorInputProtocol: AnyObject {
    var presenter: TodoDetailInteractorOutputProtocol? { get set }
    var todoItem: TodoItem? { get set }
    
    func deleteTodo()
    func saveTodo(title: String, content: String)
}

// Interactor -> Presenter
protocol TodoDetailInteractorOutputProtocol: AnyObject {
    func didDeleteTodo()
    func didSaveTodo(_ todo: TodoItem)
}

// Presenter -> Router
protocol TodoDetailRouterProtocol: AnyObject {
    static func createTodoDetailRouterModule(with todo: TodoItem?) -> UIViewController
    func navigateBackToListViewController(from view: TodoDetailViewProtocol)
}
