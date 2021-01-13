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
    var time: String { get }
    var score: String { get }
    var isFinished: Bool { get }
    
    var isPaused: Bool { get }
    func togglePause();
}
