//
//  Images.swift
//  TestCatApp
//
//  Created by Alex Stepanov on 20.05.2020.
//  Copyright © 2020 Alex Stepanov. All rights reserved.
//

import Foundation

struct Image: Decodable {
    
    
    let url: String
    let categories: [Categories]?
}

struct Categories: Decodable {
    let name: String?
    
    
}






