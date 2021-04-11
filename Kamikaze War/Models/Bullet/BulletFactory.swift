//
//  BulletFactory.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import Foundation

struct BulletFactory {
    let gameRules: GameRules
    
    func getBullets() -> [Bullet] {
        return [
            getProBullet(),
            getBasicBullet()
        ]
    }
    
    private func getBasicBullet() -> Bullet {
        return BasicBullet(velocity: 9, damage: gameRules.bulletDamage, infinite: true, isSelected: true)
    }
    
    private func getProBullet() -> Bullet {
        return ProBullet(velocity: 12, damage: gameRules.bulletDamage * 2, infinite: false, count: gameRules.proBulletsOnInit)
    }
}
