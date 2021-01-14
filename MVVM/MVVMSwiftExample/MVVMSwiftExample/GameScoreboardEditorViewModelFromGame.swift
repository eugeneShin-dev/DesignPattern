//
//  GameScoreboardEditorViewModelFromGame.swift
//  MVVMSwiftExample
//
//  Created by Hailey on 2021/01/13.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation

class GameScoreboardEditorViewModelFromGame: NSObject, GameScoreboardEditorViewModel {
    let game: Game
    
    struct Formatter {
        static let durationFormatter: DateComponentsFormatter = {
            let dateFormatter = DateComponentsFormatter()
            dateFormatter.unitsStyle = .positional
            return dateFormatter
        }()
    }
    
    var homeTeam: String
    var awayTeam: String
    
    var time: Dynamic<String>
    var score: Dynamic<String>
    var isFinished: Dynamic<Bool>
    
    var isPaused: Dynamic<Bool>
    func togglePause() {
        if isPaused.value {
            startTimer()
        } else {
            pauseTimer()
        }
        
        self.isPaused.value = !isPaused.value
    }
    
    let homePlayers: [PlayerScoreboardMoveEditorViewModel]
    let awayPlayers: [PlayerScoreboardMoveEditorViewModel]
    
    // MARK: init
    
    init(withGame game: Game) {
        self.game = game
        
        self.homeTeam = game.homeTeam.name
        self.awayTeam = game.awayTeam.name
        self.homePlayers = GameScoreboardEditorViewModelFromGame.playerViewModels(from: game.homeTeam.players, game: game)
        self.awayPlayers = GameScoreboardEditorViewModelFromGame.playerViewModels(from: game.awayTeam.players, game: game)
        
        self.time = Dynamic(GameScoreboardEditorViewModelFromGame.timeRemainingPretty(for: game))
        self.score = Dynamic(GameScoreboardEditorViewModelFromGame.scorePretty(for: game))
        self.isFinished = Dynamic(game.isFinished)
        self.isPaused = Dynamic(true)
        
        super.init()
        subscribeToNotifications()
    }
    
    deinit {
        unsubscribeFromNotifications()
    }
    
    // MARK: Notifications (Private)
    fileprivate func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(gameScoreDidChangeNotification(_:)), name: NSNotification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification), object: game)
    }
    
    fileprivate func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func gameScoreDidChangeNotification(_ notification: NSNotification) {
        self.score.value = GameScoreboardEditorViewModelFromGame.scorePretty(for: game)
        
        if game.isFinished {
            self.isFinished.value = true
        }
    }
    
    // MARK: Private
    
    fileprivate var gameTimer: Timer?
    fileprivate func startTimer() {
        let interval: TimeInterval = 0.001
        gameTimer = Timer.schedule(repeatInterval: interval) { timer in
            self.game.time += interval
            self.time = Dynamic(GameScoreboardEditorViewModelFromGame.timeRemainingPretty(for: self.game))
        }
    }
    
    fileprivate static func playerViewModels(from players: [Player], game: Game) -> [PlayerScoreboardMoveEditorViewModel] {
        var playerViewModels: [PlayerScoreboardMoveEditorViewModel] = [PlayerScoreboardMoveEditorViewModel]()
        for player in players {
            playerViewModels.append(PlayerScoreboardMoveEditorViewModelFromPlayer(withGame: game, player: player))
        }
        return playerViewModels
    }
    
    fileprivate func pauseTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    // MARK: String Utils
    fileprivate static func timeFormatted(totalMillis: Int) -> String {
        let millis: Int = totalMillis % 1000 / 100
        let totalSeconds: Int = totalMillis / 1000
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        return String(format: "%02d:%02d.%d", minutes, seconds, millis)
    }
    
    fileprivate static func timeRemainingPretty(for game: Game) -> String {
        return timeFormatted(totalMillis: Int(game.time * 1000))
    }
    
    fileprivate static func scorePretty(for game: Game) -> String {
        return String(format: "\(game.homeTeamScore) - \(game.awayTeamScore)")
    }
}
