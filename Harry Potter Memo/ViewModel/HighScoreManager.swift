//
//  HighScoreManager.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 17/04/2023.
//

import Foundation

class HighscoreManager: ObservableObject {
    private let maximumHighscoreLength = 5
    private let key = "userHighscores"

    let defaults = UserDefaults.standard
    var highscores: [PlayerHighscore] {
        get {
            if let data = defaults.data(forKey: key),
               let highscores = try? JSONDecoder().decode([PlayerHighscore].self, from: data) {
                return highscores
            }
            return []
        } set {
            let data = try? JSONEncoder().encode(newValue)
            defaults.set(data, forKey: key)
        }
    }
    
    var playerName: String {
        get {
            defaults.value(forKey: "name") as! String
        }
        set {
            defaults.set(newValue, forKey: "name")
        }
    }

    func addResult(time: Int) {
        var localHighscores = highscores
        if localHighscores.count < maximumHighscoreLength {
            localHighscores.append(PlayerHighscore(id: UUID(), name: playerName, time: time))
        } else if let index = localHighscores.firstIndex(where: { $0.time > time }) {
            localHighscores.remove(at: index)
            localHighscores.insert(.init(id: UUID(), name: playerName, time: time), at: index)
        }
        highscores = localHighscores.sorted(by: { $0.time < $1.time })
    }
}
