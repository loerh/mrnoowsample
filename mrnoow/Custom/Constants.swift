//
//  Constants.swift
//  mrnoow
//
//  Created by Laurent Meert on 11/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 The list of constants for the overall application.
 */
struct Constants {
    
    /// The API base URL
    static let apiBaseURL = "http://http://views-dev.mrnoow.com/api/"
}

/// The completion type alias for Product requests
typealias ProductsCompletion = ([Product]?) -> Void
