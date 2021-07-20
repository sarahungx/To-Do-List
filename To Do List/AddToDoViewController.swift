// ALWAYS CONNECT TO THE SCREEN
//  AddToDoViewController.swift
//  To Do List
//
//  Created by  Scholar on 7/19/21.
//

import UIKit
import CoreData


class AddToDoViewController: UIViewController {
    var previousVC = ToDoTableViewController()//to reference previous to do .. "talk to table view controller"
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func addTapped(_ sender: Any) {
//        let toDo = ToDo()
//
//        if let titleText = titleTextField.text{ //uses what the user had inputted into the textbox
//            toDo.name = titleText//whatever they typed in
//            toDo.important = importantSwitch.isOn//yes or no
//        }
//        previousVC.toDos.append(toDo)
//        previousVC.tableView.reloadData()
//        navigationController?.popViewController(animated: true)//smooth transition from the add screen to the list screen
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        } //so that we can talk to the core data
        let context = appDelegate.persistentContainer.viewContext
        
        let toDo = ToDoCD(context: context)
        
        toDo.name = titleTextField.text
        toDo.important = importantSwitch.isOn
        
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    //update toDos array with new object
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
