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
    
    let onePointMoveCount: Dynamic<String>
    let twoPointMoveCount: Dynamic<String>
    let assistMoveCount: Dynamic<String>
    let reboundMoveCount: Dynamic<String>
    let foulMoveCount: Dynamic<String>
    
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
        self.onePointMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .onePoint))")
        self.twoPointMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .twoPoints))")
        self.assistMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .onePoint))")
        self.reboundMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .onePoint))")
        self.foulMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .onePoint))")
    }
    
    fileprivate func makeMove(_ move: PlayerInGameMove) {
        game.addPlayerMove(move, for: player)
        
        onePointMoveCount.value = "\(game.playerMoveCount(for: player, move: .onePoint))"
        twoPointMoveCount.value = "\(game.playerMoveCount(for: player, move: .twoPoints))"
        assistMoveCount.value = "\(game.playerMoveCount(for: player, move: .onePoint))"
        reboundMoveCount.value = "\(game.playerMoveCount(for: player, move: .onePoint))"
        foulMoveCount.value = "\(game.playerMoveCount(for: player, move: .onePoint))"
    }
}
