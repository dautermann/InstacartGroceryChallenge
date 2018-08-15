//
//  Result.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
