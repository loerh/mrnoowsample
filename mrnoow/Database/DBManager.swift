//
//  DBManager.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit
import CoreData

/**
 A manager class for database matters.
 */
class DBManager {
    
    //MARK: Properties
    
    /// The DBManager shared instance
    static let shared = DBManager()
    
    /// The managed context of CoreData
    var managedObjectContext: NSManagedObjectContext? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK: Fetch
    
    /**
     Fetches products from CoreData.
     - returns: The converted list of Product objects.
     */
    func fetchProducts() -> [Product]? {
        
        guard let productFetchResults = fetch(forEntity: .product) else {
            return nil
        }
        var products = [Product]()
        for object in productFetchResults {
            if let product = Product(managedObject: object) {
                products.append(product)
            }
        }
        
        return products
    }
    
    //MARK: Save
    
    /**
     Saves a Product object to CoreData.
     - parameter product: The Product object to save.
     */
    func saveProduct(with product: Product) {
        
        /// Make sure we have the managed context
        guard let managedContext = managedObjectContext,
            let productEntity = NSEntityDescription.entity(forEntityName: DBEntity.product.rawValue, in: managedContext) else {
                return
        }
        
        /// Check if object already exists
        let predicate = NSPredicate(format: "\(ProductDBKey.id.rawValue) == %@", product.id)
        
        let productMO: NSManagedObject
        
        if let existingObject = fetch(forEntity: .product, predicate: predicate)?.first {
            /// We have already this object stored, update it
            productMO = existingObject
        } else {
            /// Create managed object
            productMO = NSManagedObject(entity: productEntity, insertInto: managedContext)
        }
        
        /// Setup managed object
        productMO.setValue(product.id, forKey: ProductDBKey.id.rawValue)
        productMO.setValue(product.name, forKey: ProductDBKey.name.rawValue)
        productMO.setValue(product.price, forKey: ProductDBKey.price.rawValue)
        productMO.setValue(product.productDescription, forKey: ProductDBKey.description.rawValue)
        
        /// Save managed objects
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
        
    }
    
    //MARK: Reusable Fetch
    
    /**
     Fetches from CoreData using an entity name and a predicate if needed.
     - parameter entity: The entity to fetch.
     - parameter predicate: A predicate to filter search results. Defaults to nil.
     - returns: The list of NSManagedObject results.
     */
    private func fetch(forEntity entity: DBEntity, predicate: NSPredicate? = nil) -> [NSManagedObject]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            guard let fetchResults = try managedObjectContext?.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            
            return fetchResults
            
        } catch {
            print(error)
            return nil
        }
    }
}

/**
 The list of Core Data entity names
 */
enum DBEntity: String {
    
    /// Product entity name
    case product = "ProductMO"
}
