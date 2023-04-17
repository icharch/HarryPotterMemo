//
//  Harry_Potter_MemoApp.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 15/03/2023.
//

import SwiftUI

@main
struct Harry_Potter_MemoApp: App {
    
//    @StateObject var boardViewModel = BoardViewModel()
    @AppStorage("name_typed") var currentPlayerNameTyped: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if currentPlayerNameTyped == false {
                    WelcomeView()
                } else {
                    PlayView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
//            .environmentObject(boardViewModel)
        }
    }
}
