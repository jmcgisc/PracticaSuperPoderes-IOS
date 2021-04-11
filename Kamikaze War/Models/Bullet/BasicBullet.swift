//
//  Bullet.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import ARKit

class BasicBullet: SCNNode, Bullet {
    
    var id: String = "BasicBullet"
    var notificationsId: NSNotification.Name = NSNotification.Name("NC_BasicBullet")
    var velocity: Float
    var damage: Float
    var infinite: Bool
    var count: Int?
    var isSelected: Bool
    var bulletIcon: UIImage = UIImage(named: "ic_basic_bullet") ?? UIImage()
    var bulletNode: SCNSphere = SCNSphere(radius: 0.02)
    var bulletColor: UIColor = .red
    var bulletSound: Sounds = Sounds.basicFire
    
    init(velocity: Float, damage: Float, infinite: Bool, count: Int? = nil, isSelected: Bool = false) {
        self.velocity = velocity
        self.damage = damage
        self.infinite = infinite
        self.count = count
        self.isSelected = isSelected
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
