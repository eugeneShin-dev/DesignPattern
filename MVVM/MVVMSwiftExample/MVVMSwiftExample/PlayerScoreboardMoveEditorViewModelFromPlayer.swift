//
//  PlayerScoreboardMoveEditorViewModelFromPlayer.swift
//  MVVMSwiftExample
//
//  Created by Hailey on 2021/01/13.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation

class PlayerScoreboardMoveEditorViewModelFromPlayer: NSObject, PlayerScoreboardMoveEditorViewModel {

    fileprivate let player: Player
    fileprivate let game: Game
    
    // MARK: PlayerScoreboardMoveEditorViewModel protocol
    
    var playerName: String
    
    var onePointMoveCount: String
    
    var twoPointMoveCount: String
    
    var assistMoveCount: String
    
    var reboundMoveCount: String
    
    var foulMoveCount: String
    
    func onePointMove() {
        makeMove(.onePoint)
    }
    
    func twoPointMove() {
        makeMove(.twoPoints)
    }
    
    func assistMove() {
        makeMove(.assist)
    }
    
    func reboundMove() {
        makeMove(.rebound)
    }
    
    func foulMove() {
        makeMove(.foul)
    }
    
    // MARK: Init
    init(withGame game: Game, player: Player) {
        self.game = game
        self.player = player
        
        self.playerName = player.name
        self.onePointMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
        self.twoPointMoveCount = "\(game.playerMoveCount(for: player, move: .twoPoints))"
        self.assistMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
        self.reboundMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
        self.foulMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
    }
    
    fileprivate func makeMove(_ move: PlayerInGameMove) {
        game.addPlayerMove(move, for: player)
        
        onePointMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
        twoPointMoveCount = "\(game.playerMoveCount(for: player, move: .twoPoints))"
        assistMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
        reboundMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
        foulMoveCount = "\(game.playerMoveCount(for: player, move: .onePoint))"
    }
}
