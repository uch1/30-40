//
//  Results.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 12/2/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import Foundation

struct ResultsList: Decodable {
    var results: [Results]
}

struct Results {
    var gender: String
    var firstName: String
    var lastName: String
    var photo: String?
}

extension Results: Decodable {
    
    enum ResultsKeys: String, CodingKey {
        case gender
        case name
        case picture
    }
    
    enum NameKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }
    
    enum PictureKeys: String, CodingKey {
        case photo = "large"
    }
    
    init(from decoder: Decoder) throws {
        // Results: [{}] is the main container
        let resultsContainer = try decoder.container(keyedBy: ResultsKeys.self)
        
        // Keys within the Results: [{}] container
        let gender = try resultsContainer.decode(String.self, forKey: .gender)
        
        // first and lasts names are in the Name Container e.g. name: {}
        let nameContainer = try resultsContainer.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        let firstName = try nameContainer.decodeIfPresent(String.self, forKey: .firstName) ?? "firstname not present"
        let lastName = try nameContainer.decodeIfPresent(String.self, forKey: .lastName) ?? "lastname not present"
        
        // photo is the Picture Container e.g. picture: {}
        let pictureContainer = try resultsContainer.nestedContainer(keyedBy: PictureKeys.self, forKey: .picture)
        let photo = try pictureContainer.decode(String.self, forKey: .photo)
        
        // Initializing these properties with json data
        self.init(gender: gender, firstName: firstName, lastName: lastName, photo: photo)
    }
    
}

//extension Results: Equatable {
//    static func ==(lhs: Results, rhs: Results) -> Bool {
//        return
//            lhs.firstName == rhs.firstName &&
//            lhs.lastName == rhs.lastName &&
//            lhs.photo == rhs.photo
//    }
//}







