//
//  APIManager.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

/**
 A manager for API calls.
 */
class APIManager {
    
    /// The shared instance
    static let shared = APIManager()
    
    private let baseURL = "http://http://views-dev.mrnoow.com/api/"
    
    func fetchProducts(completion: @escaping ProductsCompletion) {
        
        let additionalURL = "products"
        
        let parameters: Parameters = [
            "filter": ["storeId":"58d15ade9d4ffa000f7df597"]
        ]
        
        fetch(withAdditionalURL: additionalURL, parameters: parameters) { (json) in
            
            guard let json = json else {
                print("Could not find any JSON.")
                return
            }
            
            guard let results = json.array else {
                print("Could not find array of results")
                return
            }
            
            var products = [Product]()
            
            for result in results {
                if let product = Product.parseJSON(with: result) {
                    products.append(product)
                }
            }
            
            completion(products)
        }
    }
    
    /**
     Fetches generically from the API.
     - parameter additionalURL: The additional URL to use after base URL.
     - parameter method: The HTTPMethod to use e.g. GET, POST, PUT, ... Defaults to GET.
     - parameter parameters: The list of parameters to use for this request. Defaults to nil.
     - parameter encoding: The type of encoding. Defaults to URLEncoding.default.
     - parameter headers: The HTTPHeadears to use, if any. Defaults to nil.
     - parameter completion: The completion handler that sends back the freshly initialised JSON object, if any.
     */
    private func fetch(withAdditionalURL additionalURL: String,
                       method: HTTPMethod = .get,
                       parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: HTTPHeaders? = nil,
                       completion: @escaping (JSON?) -> Void) {
        
        let url = Constants.apiBaseURL + additionalURL
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData { (dataResponse) in
            
            /// Make sure we've got data back
            guard let data = dataResponse.result.value else {
                print("Could not find any data for this request!")
                completion(nil)
                return
            }
            
            /// Initialise JSON Object
            do {
                let json = try JSON(data: data)
                completion(json)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}
