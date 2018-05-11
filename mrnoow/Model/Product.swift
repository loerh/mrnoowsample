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
    let id: Int
    
    /// The name of that product
    let name: String
    
    /// The product description
    let productDescription: String
    
    /// The price of that product
    let price: CGFloat
    
    /**
     A basic initialiser
     */
    init(id: Int, name: String, productDescription: String, price: CGFloat) {
        self.id = id
        self.name = name
        self.productDescription = productDescription
        self.price = price
    }
    
    //MARK: JSON Parsing
    
    /**
     Parses JSON into Product object.
     - parameter json: The JSON object to parse.
     - returns: The converted Product object, if successful.
     */
    static func parseJSON(with json: JSON) -> Product? {
        
        guard let id = json[ProductKey.id.rawValue].int else {
            print("Could not find \(ProductKey.id.rawValue) key in JSON.")
            return nil
        }
        
        guard let name = json[ProductKey.name.rawValue].string else {
            print("Could not find \(ProductKey.name.rawValue) key in JSON.")
            return nil
        }
        
        guard let productDescription = json[ProductKey.id.rawValue].string else {
            print("Could not find \(ProductKey.description.rawValue) key in JSON.")
            return nil
        }
        
        guard let price = json[ProductKey.price.rawValue].float else {
            print("Could not find \(ProductKey.price.rawValue) key in JSON.")
            return nil
        }
        
        return Product(id: id, name: name, productDescription: productDescription, price: CGFloat(price))
    }
    
    /**
     Initialises object using a managed object
     */
    init?(managedObject: NSManagedObject) {
        
        /// Find the feed fields
        guard let id = managedObject.value(forKey: ProductDBKey.id.rawValue) as? Int,
            let name = managedObject.value(forKey: ProductDBKey.name.rawValue) as? String,
            let productDescription = managedObject.value(forKey: ProductDBKey.description.rawValue) as? String,
            let price = managedObject.value(forKey: ProductDBKey.price.rawValue) as? Double else {
                return nil
        }
        
        /// Initialise
        self.init(id: id, name: name, productDescription: productDescription, price: CGFloat(price))
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
}

enum ProductDBKey: String {
    case id
    case name
    case description = "productDescription"
    case price = "totalPrice"
}
