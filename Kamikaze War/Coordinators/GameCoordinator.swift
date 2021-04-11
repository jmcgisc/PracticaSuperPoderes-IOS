//
//  GameCoordinator.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import UIKit

class GameCoordinator: Coordinator {
    
    // MARK: Constants
    private let highScoreRepository: HighScoreRepository
    
    // MARK: Lifecycle
    init(highScoreRepository: HighScoreRepository) {
        self.highScoreRepository = highScoreRepository
        super.init()
    }
    
    override func start() {
        let startNewGameViewModel = StartNewGameViewModel(highScoreRepository: highScoreRepository)
        let startNewGameViewController = StartNewGameViewController(viewModel: startNewGameViewModel)
        
        startNewGameViewModel.viewDelegate = startNewGameViewController
        startNewGameViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(startNewGameViewController, animated: false)
    }
    
    override func finish() {}
    
    private func goToGame(gameMode: GameLevelMode) {
        let gameRules: GameRules
        switch gameMode {
        case .normal:
            gameRules = NormalGameRules()
        case .hard:
            gameRules = HardGameRules()
        }
        
        let gameViewModel = GameViewModel(highScoreRepository: highScoreRepository, gameRules: gameRules)
        let gameViewController = GameViewController(viewModel: gameViewModel)
        
        gameViewModel.viewDelegate = gameViewController
        gameViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(gameViewController, animated: false)
    }
}

// MARK: NewGameCoordinatorDelegate
extension GameCoordinator: NewGameCoordinatorDelegate {
    
    func startGame(gameMode: GameLevelMode) {
        goToGame(gameMode: gameMode)
    }
}

// MARK: GameCoordinatorDelegate
extension GameCoordinator: GameCoordinatorDelegate {
    
    func gameDidFinish() {
        presenter.popViewController(animated: true)
    }
}
