//
//  TableFooterView.swift
//  mrnoow
//
//  Created by Laurent Meert on 12/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The UIControl for the view cart.
 */
class ViewCartView: RoundedView {
    
    //MARK: Properties
    
    /// The section name label
    @IBOutlet weak var cartLabel: UILabel?
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cartLabel?.text = NSLocalizedString("view_cart", comment: "View Cart")
    }
}
