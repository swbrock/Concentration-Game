//
//  Concentration_GameApp.swift
//  Concentration Game
//
//  Created by Stephen Brockbank  on 10/18/23.
//

import SwiftUI

@main
struct Concentration_GameApp: App {
    var body: some Scene {
        WindowGroup {
            ConcentrationGameView(emojiGame: EmojiConcentrationGame())
        }
    }
}
