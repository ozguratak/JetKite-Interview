//
//  WebService.swift
//  task4_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation

struct Resource<T> { 
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
                
            } else {
                completion(nil)
            }
            
        } .resume()
    }
   
}
