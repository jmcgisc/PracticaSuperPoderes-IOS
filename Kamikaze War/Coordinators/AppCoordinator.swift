//
//  AppCoordinator.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    lazy private var highScoreRepository: HighScoreRepository = {
        return HighScoreUserDefaultsRepository()
    }()
    
    // MARK: Repositories Injection
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let gameCoordinator = GameCoordinator(highScoreRepository: highScoreRepository)
        addChildCoordinator(gameCoordinator)
        gameCoordinator.start()
        
        window.rootViewController = gameCoordinator.presenter
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
}
