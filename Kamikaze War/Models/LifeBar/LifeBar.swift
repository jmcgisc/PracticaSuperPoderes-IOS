//
//  LifeBar.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import ARKit
import UIKit

// MARK: LifeBarState
enum LifeBarState {
    case good
    case medium
    case bad
    
    func color() -> UIColor {
        switch self {
        case .good: return UIColor.green
        case .medium: return UIColor.yellow
        case .bad: return UIColor.red
        }
    }
}

class LifeBar: SCNNode {
    
    // MARK: Variables
    private var state: LifeBarState = .good
    private var progress: Float = 100
    
    // MARK: Constructor
    init(at position: SCNVector3) {
        super.init()
        
        let lifeBox = SCNBox(width: CGFloat(progress/100), height: 0.01, length: 0.01, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = state.color()
        material.isDoubleSided = true
        lifeBox.materials = [material]
        self.geometry = lifeBox
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: Public Functions
    func face(to objectOrientation: simd_float4x4) {
        var transform = objectOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
    }
    
    func updateWith(life: Float) {
        progress = life

        if life <= 25 {
            state = .bad
        } else if life <= 50 {
            state = .medium
        } else {
            state = .good
        }
        
        let lifeBox = SCNBox(width: CGFloat(progress/100), height: 0.01, length: 0.01, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = state.color()
        material.isDoubleSided = true
        lifeBox.materials = [material]
        self.geometry = lifeBox
    }
    
    func pause() {
        isPaused = true
    }
    
    func resume() {
        isPaused = false
    }
    
    func destroy() {
        removeFromParentNode()
    }
}
