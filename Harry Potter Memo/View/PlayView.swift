//
//  PlayView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 22/03/2023.
//

import SwiftUI

struct PlayView: View {
    
    @State var animate: Bool = false
    @AppStorage("name") var currentPlayerName: String = ""
    @State var hardness: Hardness = .easy
// MARK: BODY

    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                welcomeImage
                welcomeText
                mainTitle
                Spacer()
                HStack {
                    easyButton
                    mediumButton
                    hardButton
                }
                playButton
            }
            .padding(20)
            .onAppear(perform: addAnimation)
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}

private extension PlayView {
    
    var welcomeImage: some View {
        Image("welcomeview-harry")
            .resizable()
            .frame(width: 250, height: 250)
            .clipShape(Circle())
            .scaledToFill()
            .padding()
            .shadow(color: .gray, radius: 5, x: 0, y: 5)

    }
    
    var welcomeText: some View {
        HStack {
            Text("Hello ")
            Text(currentPlayerName)
        }
        .font(.custom("AmaticSC-Bold", size: animate ? 50 : 45))
        .padding(.horizontal, animate ? 10 : 50)
        .scaleEffect(animate ? 1.2 : 1.0)
        .offset(x: animate ? -5 : 0)
    }
    
    var playButton: some View {
        NavigationLink(
            destination: BoardView(hardness: self.hardness),
            label: {
                Text("Play")
                    .font(.custom("AmaticSC-Bold", size: 30))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
            })
    }
    
    var mainTitle: some View {
        HStack {
            Text("Select hardness and play!")
                .foregroundColor(.gray)
        }
        .font(.custom("AmaticSC-Bold", size: 45))
    }
    
    var easyButton: some View {
        Button {
            hardness = .easy
        } label: {
            Text("Easy")
                .font(.custom("AmaticSC-Bold", size: 30))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(hardness == .easy ? Color.yellow : Color.gray)
                .cornerRadius(15)
        }
    }
    
    var mediumButton: some View {
        Button {
            hardness = .medium
        } label: {
            Text("Medium")
                .font(.custom("AmaticSC-Bold", size: 30))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(hardness == .medium ? Color.yellow : Color.gray)
                .cornerRadius(15)
        }
    }
    
    var hardButton: some View {
        Button {
            hardness = .hard
        } label: {
            Text("Hard")
                .font(.custom("AmaticSC-Bold", size: 30))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(hardness == .hard ? Color.yellow : Color.gray)
                .cornerRadius(15)
        }
    }
    
// MARK: FUNCTIONS

    func addAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
            )
            {
                animate = true
            }
        }
    }
}
