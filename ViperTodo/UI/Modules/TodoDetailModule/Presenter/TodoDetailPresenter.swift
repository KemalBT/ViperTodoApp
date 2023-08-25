//
//  TodoDetailPresenter.swift
//  ViperTodo
//
//  Created by X on 9.07.2021.
//

import UIKit

class TodoDetailPresenter: TodoDetailPresenterProtocol {
    weak var view: TodoDetailViewProtocol?
    var router: TodoDetailRouterProtocol?
    var interactor: TodoDetailInteractorInputProtocol?
    
    func viewDidLoad() {
        if let todoItem = interactor?.todoItem {
            view?.showTodo(todoItem)
        }
    }
    
    //Delete command defined to be sent to interactor
    func deleteTodo() {
        interactor?.deleteTodo()
    }
    
    //Save command defined to be sent to interactor
    func saveTodo(title: String, content: String){
        interactor?.saveTodo(title: title, content: content)
    }
    
}

extension TodoDetailPresenter: TodoDetailInteractorOutputProtocol {
    
    //Callback func for removed objects
    func didDeleteTodo() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }
    }
    
    //Callback for autosaved tasks
    func didSaveTodo(_ todo: TodoItem) {
        view?.successfullySaveCallback(todo)
    }
    
}
