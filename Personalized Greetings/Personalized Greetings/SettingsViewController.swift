//
//  SettingsViewController.swift
//  Personalized Greetings
//
//  Created by Wonsug E on 5/2/19.
//  Copyright © 2019 Wonsug E. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    var personList : [PERSON] = []
    
    let previousVC = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataPerson = try? context.fetch(PERSON.fetchRequest()) as? [PERSON] {
                personList = coreDataPerson
                
                if personList.count > 0 {
                    firstNameTextField.text = personList[0].firstName
                    lastNameTextField.text = personList[0].lastName
                    ageTextField.text = personList[0].age
                    
                    let toDelete = personList[0]
                    context.delete(toDelete)
                    personList.remove(at: 0)
                    
                    try? context.save()
                }
            }
        }
    }
    
    @IBAction func saveTouch(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let person = PERSON(entity: PERSON.entity(), insertInto: context)
        person.firstName = firstNameTextField.text ?? nil
        person.lastName = lastNameTextField.text ?? nil
        person.age = ageTextField.text ?? nil
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
}
