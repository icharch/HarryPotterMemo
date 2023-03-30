//
//  StartView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 15/03/2023.
//

import SwiftUI

struct BoardView: View {
    
    @EnvironmentObject var viewModel: BoardViewModel

    // MARK: APPSTORAGE

    @AppStorage("name") var currentPlayerName: String = ""
    @AppStorage("name_typed") var currentPlayerNameTyped: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    // MARK: BODY

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    player
                    Spacer()
                    harryImage
                    Spacer()
                    playerScore
                }
                .padding()
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.cards, id: \.hashValue) { card in
                        CardView(card: card, didReverse: {
                            viewModel.flip(card: card)
                        })
                    }
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
            .environmentObject(BoardViewModel())
    }
}

// MARK: COMPONENTS

private extension BoardView {
    var playerScore: some View {
        Text("Score: ")
            .font(.custom("AmaticSC-Bold", size: 30))
            .padding(5)
            .padding(.trailing, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 2)
            )
    }

    var player: some View {
        Text(currentPlayerName)
            .font(.custom("AmaticSC-Bold", size: 30))
            .foregroundColor(.white)
            .padding(5)
            .padding(.horizontal, 10)
            .background(.green)
            .cornerRadius(15)
    }

    var harryImage: some View {
        Image("welcomeview-harry")
            .resizable()
            .clipShape(Circle())
            .scaledToFill()
            .frame(width: 70, height: 50)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
    
    // MARK: FUNCTIONS

    
}
