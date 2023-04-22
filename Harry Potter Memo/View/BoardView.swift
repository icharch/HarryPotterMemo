//
//  StartView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 15/03/2023.
//

import SwiftUI

struct BoardView: View {
    
    @ObservedObject var viewModel: BoardViewModel
    @State var timeAchieved: String = ""
    @State var highScoresDashboard: [String: String] = [:]
    @State var playerName: String = ""
    
    // MARK: APPSTORAGE

    @AppStorage("name") var currentPlayerName: String = ""
    @AppStorage("name_typed") var currentPlayerNameTyped: Bool = false
    @AppStorage("time_score") var timeScoreAchieved: String = ""
    @AppStorage("time_score_saved") var isTimeScoreSaved: Bool = false
        
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    // MARK: BODY

    init(hardness: Hardness) {
        self.viewModel = BoardViewModel(hardness: hardness)
    }
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack {
                        gameTimer
                        Spacer()
                        harryImage
                        Spacer()
                        restartButton
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.green, lineWidth: 2)
                    )
                    .padding()

                    if !viewModel.isGameResolved() {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.cards, id: \.id) { card in
                                CardView(viewModel: card)
                            }
                        }
                    }
                    else {
                        VStack {
                            gameIsCompletedView
                            highScores
                            changePlayerButton
                        }
                        .onAppear {
                            stopTimer()
                            playerScoreSaved()
                        }
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .onAppear {
            startTimer()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(hardness: .easy)
    }
}

// MARK: COMPONENTS

private extension BoardView {
    
    var changePlayerButton: some View {
        NavigationLink(
            destination: WelcomeView(),
            label: {
                Text("Change Player")
                    .font(.custom("AmaticSC-Bold", size: 30))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
            })
        .padding()
    }
    
    var highScores: some View {
        VStack {
            Text("High scores")
                .font(.custom("AmaticSC-Bold", size: 35))
            HStack {
                Text("Player")
                Spacer()
                Text("Time")
            }
            .font(.custom("AmaticSC-Bold", size: 30))
            .padding(.bottom)
            ForEach(viewModel.highscores) { highscore in
                HStack {
                    Text("\(highscore.name)")
                        Spacer()
                        Text("\(highscore.time)")
                            .font(.custom("AmaticSC-Regular", size: 30))
                    }
                    .font(.custom("AmaticSC-Regular", size: 30))
            }
        }
        .padding()
        .background(.gray)
        .cornerRadius(15)
        .padding()
        .foregroundColor(.white)
    }
    
    var restartButton: some View {
        Button(
            action: {
                
                viewModel.restart()
                startTimer()
            },
            label: {
                Image("replay-3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
        })
    }
    
    var gameTimer: some View {
        HStack {
            Text("Time: ")
            Text("\(viewModel.playTimeInSeconds)")
        }
        .font(.custom("AmaticSC-Bold", size: 30))
        .frame(height: 20)
        .padding()
        .foregroundColor(.white)
        .background(.gray.opacity(0.8))
        .cornerRadius(15)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
    
//    var playerScore: some View {
//        HStack {
//            Text("Score: ")
//            Text("\(viewModel.score)")
//        }
//            .font(.custom("AmaticSC-Bold", size: 30))
//            .frame(height: 20)
//            .padding()
//            .foregroundColor(.white)
//            .background(.gray.opacity(0.8))
//            .cornerRadius(15)
//            .shadow(color: .gray, radius: 2, x: 0, y: 2)
//    }

    var harryImage: some View {
        NavigationLink(
            destination: PlayView(),
            label: {
                Image("welcomeview-harry")
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 70, height: 50)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            })
    }
    
    var gameIsCompletedView: some View {
        VStack {
            Text("Congratulations " + "\(currentPlayerName)")
                .font(.custom("AmaticSC-Bold", size: 35))
                .foregroundColor(Color.red)
            Text("You matched all the cards!")
                .font(.custom("AmaticSC-Bold", size: 30))
            Image("trophy")
                .resizable()
                .scaledToFit()
                .shadow(color: .gray, radius: 3, x: 0, y: 3)
            Text("The House Cup is yours!")
                .font(.custom("AmaticSC-Regular", size: 25))
        }
            .multilineTextAlignment(.center)
            .frame(width: 300, height: 200)
            .clipShape(Rectangle())
            .padding()
            .background(.ultraThickMaterial)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 3, x: 0, y: 3)
    }
    
// MARK: FUNCTIONS
    
    func startTimer() {
        viewModel.startTimer()
    }
    
    func stopTimer() {
        viewModel.stopTimer()
    }
    
    func playerScoreSaved() {
        timeScoreAchieved = timeAchieved
        isTimeScoreSaved = true
    }
}
