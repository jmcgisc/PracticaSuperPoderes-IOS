//
//  HardGameRules.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import Foundation

struct HardGameRules: GameRules {
    var planesOnInit: Int = 4
    var maxPlanesOnScreen: Int = 8
    var ammoBoxesOnInit: Int = 1
    var maxAmmoBoxesOnScreen: Int = 2
    var bulletDamage: Float = 25
    var pointsForPlaneDesctruction: Int = 6
    var bulletsForAmmoBox: Int = 5
    var proBulletsOnInit: Int = 4
}
