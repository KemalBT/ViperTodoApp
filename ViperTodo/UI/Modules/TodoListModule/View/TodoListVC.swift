//
//  TodoListVC.swift
//  ViperTodo
//
//  Created by X on 8.07.2021.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //Define presenter
    var presenter: TodoListPresenterProtocol?
    
    @IBOutlet var todoListTableView: UITableView!
    
    //Reload table view when updated data
    var todos: [TodoItem] = [] {
        didSet {
            todoListTableView.reloadData()
        }
    }
    
    //Prepere for initial load
    override func viewDidLoad() {
        super.viewDidLoad()
        todoListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    //Boilerplate TableView Operations
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todos.count == 0 {
            tableView.setEmptyView(title: "You don't have any todo.", message: "Your todos will be in here.")
        }
        else {
            tableView.restore()
        }
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoListTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        presenter?.showTodoDetail(todo)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoItem = todos[indexPath.row]
            presenter?.removeTodo(todoItem)
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        presenter?.newTodo()
    }
}

extension TodoListViewController: TodoListViewProtocol {
    func showTodos(_ todos: [TodoItem]) {
        self.todos = todos
    }
}
