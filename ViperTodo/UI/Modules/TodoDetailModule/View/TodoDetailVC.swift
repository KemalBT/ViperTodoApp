//
//  TodoDetailVC.swift
//  ViperTodo
//
//  Created by X on 9.07.2021.
//

import UIKit

class TodoDetailVC: UIViewController, UITextViewDelegate {
        
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var detailTextView: UITextView!
        
    var presenter: TodoDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate assigments for textViewDidChange
        titleTextView.delegate = self
        detailTextView.delegate = self
        presenter?.viewDidLoad()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Deleting Task", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.presenter?.deleteTodo()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //Animation for
        perform(#selector(saveTodo), with: textView, afterDelay: 0.5)
    }
    
    @objc func saveTodo(_ textView: UITextView) {
        presenter?.saveTodo(title: titleTextView.text, content: detailTextView.text)
    }
}

extension TodoDetailVC: TodoDetailViewProtocol {
    func showTodo(_ todo: TodoItem) {
        titleTextView.text = todo.title
        detailTextView.text = todo.content
        self.title = todo.title
    }
    
    func successfullySaveCallback(_ todo: TodoItem) {
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.5
        fadeTextAnimation.type = .fade
        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "defAnimation")
        self.title = "Saving..."
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.title = todo.title
        }
    }
}
