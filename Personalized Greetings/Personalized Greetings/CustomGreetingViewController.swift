//
//  CustomGreetingViewController.swift
//  Personalized Greetings
//
//  Created by Wonsug E on 5/2/19.
//  Copyright © 2019 Wonsug E. All rights reserved.
//

import UIKit

class CustomGreetingViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func savePressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let greeting = GREETING(entity: GREETING.entity(), insertInto: context)
        greeting.title = titleTextField.text ?? ""
        greeting.content = contentTextView.text ?? ""
        greeting.imageTag = ""
        try? context.save()
    
        navigationController?.popViewController(animated: true)
    }
    
}
