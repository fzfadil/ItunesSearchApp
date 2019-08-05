//
//  ApiManager.swift
//  altamira
//
//  Created by recep daban on 5.08.2019.
//  Copyright © 2019 com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    
    let baseURL = "https://itunes.apple.com/search?"
    
    func makeRequestForSearch(parameters: [String: Any], completion: @escaping (JSON?) -> Void) {
        
        Alamofire.request(baseURL,
                          parameters: parameters,
                          headers: nil)
            
            .responseJSON { response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags: \(String(describing: response.result.error))")
                        completion(nil)
                        return
                }
                
                let responseJSON = JSON(value)
                
                completion(responseJSON)
        }
    }
}
