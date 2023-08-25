//
//  CoreDataStore.swift
//  Todo
//
//  Created by X on 9.07.2021.
//

import UIKit
import CoreData

class CoreDataStore  {
    public static let shared = CoreDataStore()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getAllTodos() -> [TodoItem] {
        var todoArray:[TodoItem] = []
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let id = result.value(forKey: "id") as? UUID, let title = result.value(forKey: "title") as? String, let content = result.value(forKey: "desc") as? String {
                    todoArray.append(TodoItem(id: id, title: title, content: content))
                }
            }
        } catch {
            print("CoreDataStore fetch problem")
        }
        return todoArray
    }
    
    func saveTodo(_ todo: TodoItem) {
        //print("🐝 Saving todo Item -> ID: \(todo.id)")
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [todo.id])
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                results?[0].setValue(todo.title, forKey: "title")
                results?[0].setValue(todo.content, forKey: "desc")
            } else {
                //print("🐣 New Record")
                let newTask = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: context)
                newTask.setValue(todo.id, forKey: "id")
                newTask.setValue(todo.title, forKey: "title")
                newTask.setValue(todo.content, forKey: "desc")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try context.save()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    func removeTodo(_ todo: TodoItem) {
        let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TaskEntity")
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [todo.id])
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
    }
}
