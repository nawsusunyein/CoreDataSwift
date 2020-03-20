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
    
    var names : [String] = []
    var people : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func addName(_ sender: Any) {
        let addNameAlertController = UIAlertController(title: "New Name", message: "Add new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {_ in
            guard let textField = addNameAlertController.textFields?.first,let saveName = textField.text else{
                return
            }
            self.names.append(saveName)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in})
        
        addNameAlertController.addTextField()
        addNameAlertController.addAction(saveAction)
        addNameAlertController.addAction(cancelAction)
        self.present(addNameAlertController, animated: true, completion: nil)
    }
    
    private func saveName(name : String){
        
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
