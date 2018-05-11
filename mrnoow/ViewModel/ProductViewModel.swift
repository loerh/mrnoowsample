//
//  ProductViewModel.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 The view model for products.
 */
class ProductViewModel {
    
    /**
     Fetches products from DB and API.
     */
    func fetchProducts(completion: @escaping ProductsCompletion) {
        
        /// Fetch from DB
        completion(DBManager.shared.fetchProducts())
        
        /// Fetch from API
        APIManager.shared.fetchProducts { (apiProducts) in
            
            guard let apiProducts = apiProducts else {
                completion(nil)
                return
            }
            
            /// Save to CoreData
            for apiProduct in apiProducts {
                DBManager.shared.saveProduct(with: apiProduct)
            }
            
            /// Complete
            completion(apiProducts)
        }
    }
}
