//
//  Sounds.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import AVFoundation

private class Player {
    static var current = Player()
    var player: AVAudioPlayer!
}

enum Sounds {
    
    case explosion
    case basicFire
    case proFire
    case gameOver
    case reload
    
    private var url: URL {
        switch self {
        case .explosion: return Bundle.main.url(forResource: "explosion", withExtension: "wav")!
        case .basicFire: return Bundle.main.url(forResource: "fire_basic_gun", withExtension: "wav")!
        case .proFire: return Bundle.main.url(forResource: "fire_pro_gun", withExtension: "wav")!
        case .gameOver: return Bundle.main.url(forResource: "game_over", withExtension: "mp3")!
        case .reload: return Bundle.main.url(forResource: "reload", withExtension: "wav")!
        }
    }
    
    private var type: AVFileType {
        switch self {
        case .explosion: return .wav
        case .basicFire: return .wav
        case .proFire: return .wav
        case .gameOver: return .mp3
        case .reload: return .wav
        }
    }
    
    func play() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        Player.current.player = try? AVAudioPlayer(contentsOf: self.url, fileTypeHint: self.type.rawValue)
        Player.current.player.play()
    }
    
}
