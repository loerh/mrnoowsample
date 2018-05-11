//
//  ProductTableViewCell.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The custom table view cell displaying a Product object.
 */
class ProductTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    /// The cell identifier
    static let identifier = "ProductTableViewCell"
    
    //MARK: Outlets
    
    /// The name label
    @IBOutlet weak var nameLabel: UILabel?
    
    /// The description label
    @IBOutlet weak var descriptionLabel: UILabel?
    
    /// The price label
    @IBOutlet weak var priceLabel: UILabel?
    
    //MARK: Configuration
    
    /**
     Configures the cell.
     - parameter product: The product object to configure the cell.
     */
    func configure(with product: Product) {
        nameLabel?.text = product.name
        descriptionLabel?.text = product.productDescription
        priceLabel?.text = "\(product.price) €"
    }
    
    //MARK: Functions
    
    /**
     Adds item to cart
     */
    @IBAction func addToCart() {
        
    }
}
