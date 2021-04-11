//
//  NormalGameRules.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import Foundation

struct NormalGameRules: GameRules {
    var planesOnInit: Int = 2
    var maxPlanesOnScreen: Int = 4
    var ammoBoxesOnInit: Int = 2
    var maxAmmoBoxesOnScreen: Int = 3
    var bulletDamage: Float = 50
    var pointsForPlaneDesctruction: Int = 8
    var bulletsForAmmoBox: Int = 10
    var proBulletsOnInit: Int = 25
}
