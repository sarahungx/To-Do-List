//
//  ToDoTableViewController.swift
//  To Do List
//
//  Created by  Scholar on 7/19/21.
//

import UIKit


class ToDoTableViewController: UITableViewController {
    var toDos : [ToDoCD] = [] //defaults to an empty arrays of to do objects. it will eventually contain to do objects
    
    override func viewDidLoad() {
        super.viewDidLoad() //when view loads up for user
        getToDos()
//        toDos = createToDos() //reassign todos to hold return value of createToDos function
    }

    
    
    override func viewWillAppear(_ animated: Bool){
        getToDos()
    }
//    func createToDos() -> [ToDo]{//making the function that will return the to do
//        let swift = ToDo()//referring to the class where variables were made (to be changed later on)
//        swift.name = "Learn Swift"//adding a value to the variable from the class
//        swift.important = true//changing the original deafult boolean value of important variable
//
//        let dog = ToDo()
//        dog.name = "walk the Dog"
//
//        let clean = ToDo()
//        clean.name = "Do the laundry, clean the kitchen"
//
//        return [swift, dog, clean]//returns the descriptions of each of these constants now that its attributes are changed
//    }

    
    
    func getToDos(){
        //go into core data and get all todos
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD]{
                toDos = coreDataToDos
                tableView.reloadData()
            }
        }
        //try to get objects stored inn core data
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //so we have 1 section showing up on our table
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count //so it correlates with the amount of to dos elements returned from function
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)//grabbing onto the current cell 
            
        let toDo = toDos[indexPath.row]
        
        
        
        if let name = toDo.name{
            if toDo.important{
                cell.textLabel?.text = "🔥" + name
            } else{
                cell.textLabel?.text = "⬇️" + name
            }

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    } //when user taps on a row..go look at all the to do and select which one the user tapped on and then perform a segue
//takes a hold of what the user tapped on 
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //"handshake"
        if let addVC = segue.destination as? AddToDoViewController{
            addVC.previousVC = self; //new variable to store view controller and has the property of self, which references the current class
        }
        //if ur going to table to complete page..do this stuff
        if let completeVC = segue.destination as? CompleteToDoViewController{
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
        
    }
    //right after the user triggers a segway, but right before the segway happens, this code with run (connect table to add page)

}
