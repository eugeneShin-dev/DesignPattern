//
//  GameScoreboardEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by Hailey on 2021/01/13.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation

protocol GameScoreboardEditorViewModel {
    var homeTeam: String { get }
    var awayTeam: String { get }
    var homePlayers: [PlayerScoreboardMoveEditorViewModel] { get }
    var awayPlayers: [PlayerScoreboardMoveEditorViewModel] { get }
    
    var time: Dynamic<String> { get }
    var score: Dynamic<String> { get }
    var isFinished: Dynamic<Bool> { get }
    
    var isPaused: Dynamic<Bool> { get }
    func togglePause();
}
