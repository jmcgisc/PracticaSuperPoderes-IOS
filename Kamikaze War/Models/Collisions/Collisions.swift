//
//  Collisions.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import Foundation

struct Collisions: OptionSet {
    let rawValue: Int
    
    static let plane = Collisions(rawValue: 1 << 0)
    static let bullet = Collisions(rawValue: 1 << 1)
    static let ammoBox = Collisions(rawValue: 1 << 2)
}
