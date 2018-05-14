//
//  Product.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftyJSON
import CoreData

/**
 The Product model struct.
 */
struct Product {
    
    //MARK: Properties
    
    /// ID for that product
    let id: String
    
    /// The name of that product
    let name: String
    
    /// The product description
    let productDescription: String
    
    /// The price of that product
    let price: Float
    
    /// List of key words
    let keyword: String
    
    /**
     A basic initialiser
     */
    init(id: String, name: String, productDescription: String, price: Float, keyword: String) {
        self.id = id
        self.name = name
        self.productDescription = productDescription
        self.price = price
        self.keyword = keyword
    }
    
    //MARK: JSON Parsing
    
    /**
     Parses JSON into Product object.
     - parameter json: The JSON object to parse.
     - returns: The converted Product object, if successful.
     */
    static func parseJSON(with json: JSON) -> Product? {
        
        guard let id = json[ProductKey.id.rawValue].string else {
            print("Could not find \(ProductKey.id.rawValue) key in JSON.")
            return nil
        }
        
        guard let name = json[ProductKey.name.rawValue].string else {
            print("Could not find \(ProductKey.name.rawValue) key in JSON.")
            return nil
        }
        
        guard let productDescription = json[ProductKey.description.rawValue].string else {
            print("Could not find \(ProductKey.description.rawValue) key in JSON.")
            return nil
        }
        
        guard let price = json[ProductKey.price.rawValue].float else {
            print("Could not find \(ProductKey.price.rawValue) key in JSON.")
            return nil
        }
        
        guard let keyword = json[ProductKey.keywords.rawValue].array?.first?.string else {
            return nil
        }
        
        return Product(id: id, name: name, productDescription: productDescription, price: price, keyword: keyword)
    }
    
    /**
     Initialises object using a managed object
     */
    init?(managedObject: NSManagedObject) {
        
        /// Find the feed fields
        guard let id = managedObject.value(forKey: ProductDBKey.id.rawValue) as? String,
            let name = managedObject.value(forKey: ProductDBKey.name.rawValue) as? String,
            let productDescription = managedObject.value(forKey: ProductDBKey.description.rawValue) as? String,
            let price = managedObject.value(forKey: ProductDBKey.price.rawValue) as? Float,
        let keyword = managedObject.value(forKey: ProductDBKey.keyword.rawValue) as? String else {
                return nil
        }
        
        /// Initialise
        self.init(id: id, name: name, productDescription: productDescription, price: price, keyword: keyword)
    }
}

/**
 The list of keys to parse the JSON object into a Product object.
 */
enum ProductKey: String {
    
    /// Product ID
    case id
    
    /// Name
    case name
    
    /// Description
    case description
    
    /// Total price
    case price = "total"
    
    /// Keywords
    case keywords
}

enum ProductDBKey: String {
    case id
    case name
    case description = "productDescription"
    case price = "totalPrice"
    case keyword
}
