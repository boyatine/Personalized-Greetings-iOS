//
//  CoreDataHelper.swift
//  Personalized Greetings
//
//  Created by Wonsug E on 5/2/19.
//  Copyright © 2019 Wonsug E. All rights reserved.
//

import UIKit
import CoreData

var titles:[String] = ["Birthday", "Anniversary", "Get Well", "Retirement", "Newborn Baby", "College Acceptance", "Graduation", "Got a Job", "Promotion at Work", "Funeral",  "Wedding", "Serious Illness", "Borrow Money Shamelessly", "Dog Gave Birth", "Sent to Jail", "Won a Lawsuit"]

var contents:[String] = ["Age is just a number, especially after AGE! In your case, the number is getting really big! Have an amazing birthday FIRST NAME!",
                         "FIRST NAME, every anniversary makes me look back at our relationship and realize that I had the best twelve months of my life.",
                         "Hey FIRST NAME, it feels horrible to hear that you are so sick. Please take care of yourself my dear. Get well soon.",
                         "Hey FIRST NAME, you always brightened up our workplace! We will miss your smiling face, and hope that you'll visit us when you have time. Farewell partner!",
                         "Behold! A baby miracle has fallen upon the LAST NAME home. Congratulations on your new child!",
                         "OMG FIRST NAME!!! CONGRATS!!! You did it! You're officially a college student! It only took AGE years!",
                         "It only seems like yesterday when you were headed off to college. Congrats to FIRST NAME LAST NAME for finally heading out to the real world!",
                         "Congratulations FIRST NAME, what an achievement! Now you're ready to take off. Wishing you smooth and enjoyable transition into your new job!",
                         "So glad to hear about your promotion. May your life always be filled with such good opportunities.",
                         "I was deeply saddened to hear about FIRST NAME's passing. I offer my condolences to you and your family.",
                         "Once Upon a Time is really here & now! Congrats on your wedding and best wishes for a happy marriage in the years ahead!",
                         "Dear FIRST NAME! Please accept my heartfelt sympathy in this painful time as you are fighting with your sickeness. Take care and remember that we love you and care about you.",
                         "How are you FIRST NAME? I know it's been a long time since we spoke, but I am in a financial crisis and could really use some help. If you could spare me some money, please let me know ASAP. Thanks.",
                         "Yo FIRST NAME I heard your dog recently had puppies. Can I get one?",
                         "Hey I just saw on TV that a AGE year old \"FIRST NAME LAST NAME\" was wanted and on the run, that's not you is it?",
                         "Hey FIRST NAME I heard that you finally won that lawsuit! Hurray for justice! Hope your life returns to normal soon."]

var imageTags:[String] = ["birthday", "anniversary", "getwell", "retirement", "baby", "college", "graduation", "job", "promotion", "funeral", "wedding", "illness",
                            "money", "dog", "jail", "lawsuit"]

func addAllGreetings() {
    for i in 0...titles.count-1 {
        createGreeting(title: titles[i], content: contents[i], imageTag: imageTags[i])
    }
    
}

func createGreeting(title : String, content : String, imageTag : String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let greeting = GREETING(entity: GREETING.entity(), insertInto: context)
    greeting.title = title
    greeting.content = content
    greeting.imageTag = imageTag
    try? context.save()
}

func getAllGreetings() ->[GREETING] {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        if let greetings = try? context.fetch(GREETING.fetchRequest()) as? [GREETING] {
            if greetings.count == 0 {
                addAllGreetings()
                return getAllGreetings()
            } else {
                return greetings
            }
        }
    }
    return []
}
