//
//  GamePlayVC.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 12/8/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class GamePlayVC: UIViewController {

    // MARK: IBOutlet variables
    @IBOutlet weak var guessNameLabel: UILabel!
    @IBOutlet weak var personDisplayImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    
    
    
    // Timer
    var seconds = 20
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    // MARK: Properties
    //var recievedPersonImage: UIImage?
    var people: [Results] = []
    // var randomPeople: [Results] = [] randomly select
    // and store pictures to trick the user 
    //var diplayedPerson = getRandomPerson()
    var guesses: [String: [String]] = ["wrong": [], "correct": []]
    var actualName: String = ""
    var photo: String = ""
    var randomGivenName: String = ""
    var counter = 5
    

    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        //let g = getRandomPerson()
        //personDisplayImageView.getImageFromURL(url: (people[g].photo)!)
        //personDisplayImageView.image = displayPerson
        //print(g)
        runTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //personDisplayImageView.image =
        //personDisplayImageView.getImageFromURL(url: (people[g].photo)!)
        //print(randomPerson)
        //print(randomName)
        //let randomPerson = getRandomPerson()
        //let randomName = getRandomName()
        //self.randomGivenName = randomName
//        self.randomGivenName = getRandomName()
//        guessNameLabel.text = "Who is it? \(randomGivenName)?"
//        getNameAndPhoto()
//        personDisplayImageView.getImageFromURL(url: self.photo)
        update()
    }
    
    func update() {
        // Once called, update() changes the random name and photo
        self.randomGivenName = getRandomName()
        getNameAndPhoto()
        guessNameLabel.text = "Who is it? \(randomGivenName)?"
        personDisplayImageView.getImageFromURL(url: self.photo)
    }
    
    func getNameAndPhoto() {
        /* generates a random name and photo using an indexpath
           fullName: String Interpolation of first and last names
         */
        
        let index = Int(arc4random()) % people.count
        
        
        let fullName = "\(people[index].firstName.capitalized) \(people[index].lastName.capitalized)"
        
        self.actualName = fullName
        self.photo = people[index].photo!
        people.remove(at: index)
        self.counter -= 1
    }
    
    func getRandomName() -> String {
        //print(people.count)
        let index = Int(arc4random()) % people.count
        //print(index)
        //let fullName = people[index].firstName + " " + people[index].lastName
        let fullName = ("\(people[index].firstName.capitalized) \(people[index].lastName.capitalized)")
        return fullName
    }
    
//    func checkEachPhoto() {
//        var counter = 5
//        self.photo
//
//    }
    
    // MARK: IBAction FUNCTIONS
    @IBAction func noButtonTapped(_ sender: Any) {

        if self.randomGivenName != actualName {
           guessNameLabel.text = "You're right! Its \(self.actualName)"
            if guesses["correct"]! == [] {
                guesses["correct"] = [self.photo]
            } else {
                guesses["correct"]?.append(self.photo)
            }
        }
        else {
          guessNameLabel.text = "Your guess was wrong, it was \(self.actualName)"
            
            if guesses["wrong"]! == [] {
                guesses["wrong"] = [self.photo]
            } else {
                guesses["wrong"]?.append(self.photo)
            }
            
        }
        noButton.isEnabled = false
        yesButton.isEnabled = false
        nextButton.isEnabled = true
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {

        if self.randomGivenName == self.actualName {
             guessNameLabel.text = "You're right! Its \(self.actualName)"
            
            if guesses["correct"]! == [] {
                guesses["correct"] = [self.photo]
            } else {
                guesses["correct"]?.append(self.photo)
            }
        }
        else {
           guessNameLabel.text = "Your guess was wrong, it was \(self.actualName)"
            
            if guesses["wrong"]! == [] {
                guesses["wrong"] = [self.photo]
            } else {
                guesses["wrong"]?.append(self.photo)
            }
            
        }
        noButton.isEnabled = false
        yesButton.isEnabled = false
        nextButton.isEnabled = true
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if self.counter == 0 {
            
            let gameResultsVC = storyboard?.instantiateViewController(withIdentifier: "GameResultsVC") as! GameResultsVC
            gameResultsVC.guesses = self.guesses
            
            self.navigationController?.pushViewController(gameResultsVC, animated: true)
        } else {
            update()
        }
        
        noButton.isEnabled = true
        yesButton.isEnabled = true
        nextButton.isEnabled = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToGameResultsVC" {
            let gameResults = segue.destination as! GameResultsVC
            gameResults.guesses = self.guesses
            
        }
    }
    
    
    @IBAction func xButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "fromGamePlaytoHomeScreen", sender: GamePlayVC.self)
    }
    
}

extension GamePlayVC {
    // runtimer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GamePlayVC.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    //
    // why is there an @objc keyword?
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            performSegue(withIdentifier: "segueToGameResultsVC", sender: self.guesses)

        } else {
            seconds -= 1 //This will decrement(count down) the seconds.
            timerLabel.text = timeString(time: TimeInterval(seconds)) //This will update the label.
        }
    }
    
    // timeString will format the time hours: minutes: seconds
    func timeString(time: TimeInterval) -> String {
        //let hours = Int(time) / 3600
        //let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%2i", seconds)
    }
    
    
    
    
}

//extension GamePlayVC: PersonDelegate{
//    func receivedImageAndName(with person: [Results]) {
//       self.personInfo = person
//       // self.reloadInputViews()
//    }
//}

//            let gameResultsVC = storyboard?.instantiateViewController(withIdentifier: "GameResultsVC") as! GameResultsVC
//            gameResultsVC.guesses = self.guesses
//
//            self.navigationController?.pushViewController(gameResultsVC, animated: true)
//            let timeOutAlert = UIAlertController(title: "TIME'S UP", message: "Please make better use of your time", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
//            let cancelAction2 = UIAlertAction(title: "Nah Homie", style: .destructive, handler: nil)
//            timeOutAlert.addAction(cancelAction)
//            timeOutAlert.addAction(cancelAction2)
//            self.present(timeOutAlert, animated: true, completion: nil)










