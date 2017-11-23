//
//  PersonCollectionViewCell.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 11/21/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    var person: Person? {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: Methods
    private func updateUI() {
        
        if let person = person {
            personImageView.image = person.image
            personNameLabel.text = person.name
        } else {
            personImageView.image = nil
            personNameLabel.text = nil
        }
    }
/*
     Create a shadow for the CollectionViewCell and bound it to the uiview
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
*/
    
    
}























