//
//  TodoDetailProtocol.swift
//  ViperTodo
//
//  Created by X on 9.07.2021.
//

import UIKit

class TodoDetailRouter: TodoDetailRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func navigateBackToListViewController(from view: TodoDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createTodoDetailRouterModule(with todo: TodoItem?) -> UIViewController {
        guard let todoDetailVC = storyboard.instantiateViewController(withIdentifier: "TodoDetailViewController") as? TodoDetailVC else {
            fatalError("Invalid view controller type")
        }
        
        let presenter: TodoDetailPresenter & TodoDetailInteractorOutputProtocol = TodoDetailPresenter()
        todoDetailVC.presenter = presenter
        presenter.view = todoDetailVC
        let interactor: TodoDetailInteractorInputProtocol = TodoDetailInteractor()
        if let todo = todo {
            interactor.todoItem = todo
        }else{
            //print("🆕 Creating new todo at runtime")
            interactor.todoItem = TodoItem(id: UUID(), title: "", content: "")
        }
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: TodoDetailRouterProtocol = TodoDetailRouter()
        presenter.router = router
        
        return todoDetailVC
    }
}
