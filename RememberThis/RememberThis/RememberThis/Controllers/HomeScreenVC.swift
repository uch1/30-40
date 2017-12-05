//
//  HomeScreenVC.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 11/20/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Methods
    //
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "segueToGameLoadVC", sender: self)
    }
    //
    @IBAction func learnButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "segueToLearnAboutVC", sender: self)
    }
    
    
    
}

