//
//  GameRules.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import Foundation

protocol GameRules {
    var planesOnInit: Int { get }
    var maxPlanesOnScreen: Int { get }
    var ammoBoxesOnInit: Int { get }
    var maxAmmoBoxesOnScreen: Int { get }
    var bulletDamage: Float { get }
    var pointsForPlaneDesctruction: Int { get }
    var bulletsForAmmoBox: Int { get }
    var proBulletsOnInit: Int { get }
}
