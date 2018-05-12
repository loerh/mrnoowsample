//
//  ViewController.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The view controller showing the store and its products.
 */
class ProductsViewController: UIViewController {

    /// The table view for products
    @IBOutlet weak var productsTableView: ProductsTableView?
    
    /// The activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Load the data
        loadData()
    }

    /**
     Loads data.
     */
    private func loadData() {
        
        self.productsTableView?.alpha = 0
        let viewModel = ProductViewModel()
        
        viewModel.fetchProducts { (products) in
            
            if let products = products, products.count > 0 {
                
                self.productsTableView?.setup(with: products)
                UIView.animate(withDuration: 0.4) {
                    self.productsTableView?.alpha = 1
                }
                self.activityIndicator?.stopAnimating()
            }
        }
    }
}

