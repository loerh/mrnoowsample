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
    
    /// The data displayed on the table view as a dictionary containing sections as key and list of corresponding products as value
    private var data: [String: [Product]]?
    
    //MARK: Setup
    
    /**
     Sets up the tableview.
     - parameter data: The data to assign and display for this table view.
     */
    func setup(with products: [Product]) {
        delegate = self
        dataSource = self
        setupData(with: products)
        reloadData()
    }
    
    private func setupData(with products: [Product]) {
        var data = [String: [Product]]()
        
        for product in products {
            if data[product.keyword] == nil {
                data[product.keyword] = [Product]()
            }
            data[product.keyword]?.append(product)
        }
        
        self.data = data
    }
}

extension ProductsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = data {
        
            let keys = Array(data.keys)
            let section = keys[indexPath.section]
            
            if let product = data[section]?[indexPath.row] {
                cell.configure(with: product)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            let keys = Array(data.keys)
            return data[keys[section]]?.count ?? 0
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0
    }
}

extension ProductsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = Bundle.main.loadNibNamed(TableHeaderView.nibName, owner: self, options: nil)?.first as? TableHeaderView
        sectionHeaderView?.sectionNameLabel?.text = getSectionName(for: section)
        
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    /**
     Gets the section name.
     - parameter section: The section for which to get the name.
     - returns: The section name.
     */
    private func getSectionName(for section: Int) -> String? {
        if let data = data {
            return Array(data.keys)[section].uppercased()
        }
        return nil
    }
}
