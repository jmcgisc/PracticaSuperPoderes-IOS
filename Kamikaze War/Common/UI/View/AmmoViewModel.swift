//
//  AmmoViewModel.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import UIKit

protocol AmmoViewDelegate: class {
    func bulletUpdated()
}

class AmmoViewModel {
    
    // MARK: Variables
    weak var viewDelegate: AmmoViewDelegate?
    var bullet: Bullet
    var icon: UIImage { return bullet.bulletIcon }
    var color: UIColor { return bullet.bulletColor }
    var countText: String { return bullet.infinite ? "∞" : "\(bullet.count ?? 0)" }
    var isSelected: Bool { return bullet.isSelected }
    
    // MARK: Lifecycle
    init(bullet: Bullet) {
        self.bullet = bullet
    }
    
    // MARK: Public Functions
    func viewWasLoaded() {
        addObservers()
    }
    
    // MARK: Private Functions
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(bulletDidChanged(_:)), name: bullet.notificationsId, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: bullet.notificationsId, object: nil)
    }
    
    @objc private func bulletDidChanged(_ notification: Notification) {
        guard let bullet = notification.object as? Bullet else {
            return
        }
        
        self.bullet = bullet
        viewDelegate?.bulletUpdated()
    }
}
