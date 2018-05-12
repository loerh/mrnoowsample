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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = Bundle.main.loadNibNamed(TableHeaderView.nibName, owner: self, options: nil)?.first as? TableHeaderView
        sectionHeaderView?.sectionNameLabel?.text = getSectionName(for: section)
        
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return Bundle.main.loadNibNamed("TableFooterView", owner: self, options: nil)?.first as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 65
    }
    
    /**
     Gets the section name.
     - parameter section: The section for which to get the name.
     - returns: The section name.
     */
    private func getSectionName(for section: Int) -> String? {
        switch section {
        case 0:
            return "SMOOTHIES"
        default:
            return nil
        }
    }
}
