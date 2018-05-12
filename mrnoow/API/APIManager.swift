//
//  APIManager.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import SwiftyJSON


/**
 A manager for API calls.
 */
class APIManager {
    
    /// The shared instance
    static let shared = APIManager()
    
    /**
     Fetches products.
     */
    func fetchProducts(completion: @escaping ProductsCompletion) {
        
        if let url = URL(string: "http://views-dev.mrnoow.com/api/products?filter=%7B%22storeId%22%3A%2258d15ade9d4ffa000f7df597%22%7D") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSON(data: data)
                        guard let results = json.array else {
                            print("Could not find array of results")
                            return
                        }
                        
                        var products = [Product]()
                        var amount = 0
                        for result in results {
                            /// Limit items amount to 20 for the sake of performance and exercise. Pagination could be use to cope with that.
                            if amount > 20 {
                                break
                            }
                            
                            if let product = Product.parseJSON(with: result) {
                                products.append(product)
                                amount += 1
                            }
                        }
                        
                        completion(products)
                    } catch {
                        print(error)
                    }
                }
            }
            
            task.resume()
        }
    }
}
