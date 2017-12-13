//
//  Networking.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 11/22/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import Foundation

class Networking {
    
    let session = URLSession.shared
    let baseURL = "https://randomuser.me/api/"
    
    func fetch(resource: Resource, completion: @escaping (Data) -> ()) {
        // fullUrl is the url needed for making a request to RandomUserAPI
        let fullUrl = baseURL.appending(resource.path())
        let url = URL(string: fullUrl)!
        
        // URL Request
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod().rawValue

        
        // Start the URL Session *note: Closure/callback
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                //let resultList = try? JSONDecoder().decode(ResultsList.self, from: data)
                //guard let results = resultList?.results else {return}
                completion(data)
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }.resume()
    }    
}
