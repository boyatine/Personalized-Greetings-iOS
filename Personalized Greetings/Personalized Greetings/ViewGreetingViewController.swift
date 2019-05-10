//
//  ViewGreetingViewController.swift
//  Personalized Greetings
//
//  Created by Wonsug E on 5/2/19.
//  Copyright © 2019 Wonsug E. All rights reserved.
//

import UIKit
import MessageUI

class ViewGreetingViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    var previousVC = TableViewController()
    var location  = -1
    
    var personList : [PERSON] = []

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataPerson = try? context.fetch(PERSON.fetchRequest()) as? [PERSON] {
                personList = coreDataPerson
            }
        }
        
        if ( personList.count > 0 ) {
            var tempContent = previousVC.greetingList[location].content
            tempContent = tempContent?.replacingOccurrences(of: "FIRST NAME", with: personList[0].firstName ?? "FIRST NAME")
            tempContent = tempContent?.replacingOccurrences(of: "LAST NAME", with: personList[0].lastName ?? "LAST NAME")
            tempContent = tempContent?.replacingOccurrences(of: "AGE", with: String(personList[0].age ?? "AGE"))
            contentLabel.text = tempContent
        } else {
            contentLabel.text = previousVC.greetingList[location].content
        }
        
        titleLabel.text = previousVC.greetingList[location].title
        imageView.image = UIImage(named: previousVC.greetingList[location].imageTag! + ".jpg")
    }
    
    @IBAction func emailPressed(_ sender: Any) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([""])
        composeVC.setSubject(titleLabel.text ?? "")
        composeVC.setMessageBody(contentLabel.text ?? "", isHTML: false)
        composeVC.mailComposeDelegate = self
        
        if let image = UIImage(named: previousVC.greetingList[location].imageTag! + ".jpg") {
            composeVC.addAttachmentData(image.jpegData(compressionQuality: 1.0)!, mimeType: "image/jpeg", fileName: previousVC.greetingList[location].imageTag! + ".jpg")
        }
        
        // Present the view controller modally.
        present(composeVC, animated: true, completion: nil)
    }
    
    @IBAction func textPressed(_ sender: Any) {
        if !MFMessageComposeViewController.canSendText() {
            print("Text services are not available")
            return
        }
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.body = contentLabel.text
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    
    private func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
