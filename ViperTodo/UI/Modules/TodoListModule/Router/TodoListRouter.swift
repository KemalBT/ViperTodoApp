//
//  TodoListRouter.swift
//  ViperTodo
//
//  Created by X on 8.07.2021.
//

import UIKit

class TodoListRouter: TodoListRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createTodoListModule() -> UIViewController {
        let navController = storyboard.instantiateViewController(withIdentifier: "TodoListNavigationController") as! UINavigationController
        guard let todoListViewController = navController.topViewController as? TodoListViewController else {fatalError("Invalid VC warning at TodoListVC")}
        
        //Presenter must be confirm related protocols.
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        let interactor: TodoListInteractorInputProtocol = TodoListInteractor()
        let router = TodoListRouter()
        
        todoListViewController.presenter = presenter
        presenter.view = todoListViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navController
    }
    
    //Navigate to TodoDetail Module
    func presentToDoDetailScreen(from view: TodoListViewProtocol, for todo: TodoItem?) {
        var todoDetailVC: UIViewController = UIViewController()
        
        //First checkpoint for new registration. If the todo object does not exist, it is going to pass as nil.
        todoDetailVC = TodoDetailRouter.createTodoDetailRouterModule(with: todo ?? nil)
        
        //Check for unpredictable view control issues.
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        //Navigate to related view via navigation controller
        viewVC.navigationController?.pushViewController(todoDetailVC, animated: true)
    }
}
