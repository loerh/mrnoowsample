//
//  TableHeaderView.swift
//  mrnoow
//
//  Created by Laurent Meert on 12/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The view for the table header in sections.
 */
class TableHeaderView: UIView {
    
    //MARK: Properties
    
    /// The nib name
    static let nibName = "TableHeaderView"
    
    /// The section name label
    @IBOutlet weak var sectionNameLabel: UILabel?
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addBorder(edge: .top)
        layer.addBorder(edge: .bottom)
    }
}
