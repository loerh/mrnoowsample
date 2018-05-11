//
//  ProductsTableView.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The table view displaying products
 */
class ProductsTableView: UITableView {
    
    //MARK: Properties
    
    /// The products displayed on the table view
    private var products: [Product]?
    
    //MARK: Setup
    
    /**
     Sets up the tableview.
     - parameter data: The data to assign and display for this table view.
     */
    func setup(with products: [Product]) {
        delegate = self
        dataSource = self
        self.products = products
        reloadData()
    }
}

extension ProductsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        if let product = products?[indexPath.row] {
            cell.configure(with: product)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    
}

extension ProductsTableView: UITableViewDelegate {
    
}
