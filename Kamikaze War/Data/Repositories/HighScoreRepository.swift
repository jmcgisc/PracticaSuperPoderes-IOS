//
//  HighScoreRepository.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import Foundation

protocol HighScoreRepository {
    func getHighScore() -> Int
    func setHighScore(_ highScore: Int)
    func resetHighScore()
}
