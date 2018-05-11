//
//  ViewController.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var productsTableView: ProductsTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    private func loadData() {
        let viewModel = ProductViewModel()
        viewModel.fetchProducts { (products) in
            if let products = products {
                self.productsTableView?.setup(with: products)
            }
        }
    }
}

