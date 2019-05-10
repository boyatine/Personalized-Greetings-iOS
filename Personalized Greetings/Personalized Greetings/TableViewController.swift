//
//  TableViewController.swift
//  Personalized Greetings
//
//  Created by Wonsug E on 5/2/19.
//  Copyright © 2019 Wonsug E. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var greetingList : [GREETING] = []
    var personList : [PERSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        greetingList = getAllGreetings()
        getItems()
        getPerson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getItems()
    }
    
    func getItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataGreetings = try? context.fetch(GREETING.fetchRequest()) as? [GREETING] {
                greetingList = coreDataGreetings
                tableView.reloadData()
            }
        }
    }
    
    func getPerson() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataPerson = try? context.fetch(PERSON.fetchRequest()) as? [PERSON] {
                personList = coreDataPerson
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return greetingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = greetingList[indexPath.row].title
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let toDelete = greetingList[indexPath.row]
                context.delete(toDelete)
                greetingList.remove(at: indexPath.row)
                try? context.save()
            }
            
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let infoVC =  segue.destination as? ViewGreetingViewController  {
            infoVC.previousVC = self;
            infoVC.location = sender as! Int
        }
    }
}
