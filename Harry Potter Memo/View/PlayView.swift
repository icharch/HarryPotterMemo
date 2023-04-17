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
    
// MARK: BODY

    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                welcomeImage
                welcomeText
                mainTitle
                Spacer()
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
            .clipShape(Circle())
            .scaledToFill()
            .padding()
            .shadow(color: .gray, radius: 5, x: 0, y: 5)

    }
    
    var welcomeText: some View {
        HStack {
            Text("Hey ")
            Text(currentPlayerName)
            Text("!")
        }
        .font(.custom("AmaticSC-Bold", size: animate ? 50 : 45))
        .padding(.horizontal, animate ? 10 : 50)
        .scaleEffect(animate ? 1.2 : 1.0)
        .offset(x: animate ? -5 : 0)
    }
    
    var playButton: some View {
        NavigationLink(
            destination: BoardView(),
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
            Text("Have fun and")
                .foregroundColor(.gray)
            Text("Memo")
                .foregroundColor(.red)
        }
        .font(.custom("AmaticSC-Bold", size: 45))
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
