//
//  ViewController.swift
//  CoreDataTestProject
//
//  Created by techfun on 2020/03/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated : Bool){
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do{
            people = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("Could not fetch : \(error) , \(error.userInfo)")
        }
    }
    
    @IBAction func addName(_ sender: Any) {
        let addNameAlertController = UIAlertController(title: "New Name", message: "Add new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {_ in
            guard let textField = addNameAlertController.textFields?.first,let saveName = textField.text else{
                return
            }
            self.saveName(name: saveName)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in})
        
        addNameAlertController.addTextField()
        addNameAlertController.addAction(saveAction)
        addNameAlertController.addAction(cancelAction)
        self.present(addNameAlertController, animated: true, completion: nil)
    }
    
    private func saveName(name : String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do{
            try managedContext.save()
            people.append(person)
        }catch let error as NSError{
            print("Could not save \(error) , \(error.userInfo)")
        }
    }

}

extension ViewController : UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
    
    
}
