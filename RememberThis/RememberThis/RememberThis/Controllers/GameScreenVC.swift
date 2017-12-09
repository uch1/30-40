//
//  GameScreenVC.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 12/3/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

// PersonDelegate will send person's image and name
// to the next view controller
protocol PersonDelegate: class  {
    func receivedImageAndName(with person: [Results])
}

class GameScreenVC: UIViewController {
//    func receivedImageAndName(with person: [Results]) {
//        // nothing to do
//    }
    
    
    // MARK: Properties
    
    // IBOutlets are UI Element placed on the Storyboard
    @IBOutlet weak var personCard: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    //weak var delegate : PersonDelegate?
    
    // Time Properties
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    // Property observer reloads the data
    // once the CollectionViewCell changes
    var people = [Results]() {
        didSet {
            DispatchQueue.main.async {
                self.personCard.reloadData()
            }
        }
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runTimer() // will start the timer
        
        personCard.delegate = self
        personCard.dataSource = self
        //delegate = self as? PersonDelegate
        
        let layout = self.personCard.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 20)
        //
        // Create an instance of Networking to GET data from API
        let networking = Networking()
        networking.fetch(resource: .results) { (data) in
            let resultList = try? JSONDecoder().decode(ResultsList.self, from: data)
            guard let personInfo = resultList?.results else {return}
            self.people = personInfo
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Once ready button is tapped, the timer will stop and
    // GameScreenVC will transition to the GamePlayVC
    @IBAction func readyButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        }
        self.performSegue(withIdentifier: "segueToGamePlayVC", sender: self.people)
    }
    
    @IBAction func xbuttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "segueXtoHomeScreen", sender: GameScreenVC.self)
    }
    
    
}

//=================================== CollectionView Implementation ==================================================
extension GameScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        
        let persons = people[indexPath.row]
        
        cell.personNameLabel.text = "\(persons.firstName.capitalized) \(persons.lastName.capitalized)"
        
        DispatchQueue.main.async {
            cell.personImageView?.getImageFromURL(url: persons.photo!)
        }
        cell.layer.cornerRadius = 5
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segueToGamePlayVC" {
            let gamePlay = segue.destination as! GamePlayVC
            gamePlay.people = self.people
           
        }
    }
    
}

//extension GameScreenVC: UIScrollViewDelegate {
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        let index = Int(scrollView.contentOffset.x / scrollView.contentSize.width)
//        let item = persons[index]
//
//    }
//}

//================================ TIMER FUNCTIONALITY =================================
extension GameScreenVC {
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScreenVC.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    // why is there an @objc keyword?
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            // Once the countdown is 0 send the user to the next screen
            performSegue(withIdentifier: "segueToGamePlayVC", sender: self.people)
            
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











