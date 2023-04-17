//
//  WelcomeView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 15/03/2023.
//

import SwiftUI

struct WelcomeView: View {
    
// MARK: VARIABLES
    
    @State var playerName: String = ""
    @FocusState var playerInFocus: Bool
    @State var animate: Bool = false
    @State var alertType: PlayerNameError?
    @AppStorage("name") var currentPlayerName: String = ""
    @AppStorage("name_typed") var currentPlayerNameTyped: Bool = false
    

// MARK: ALERT TYPES
    
    enum PlayerNameError: Identifiable {
        var id: Int {
                hashValue
            }
        case tooShort
    }
    
// MARK: BODY
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                welcomeImage
                welcomeText
                welcomeTextField
                saveButton
            }
            .padding(20)
            .onAppear(perform: addAnimation)
        }
        .alert(item: $alertType) { alertType in
            switch alertType {
            case .tooShort:
                return Alert(title: Text("Your name is too short.. Please type again!"))
            }
        }
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

// MARK: COMPONENTS

private extension WelcomeView {
    
    var welcomeImage: some View {
        Image("welcomeview-harry")
            .resizable()
            .clipShape(Circle())
            .scaledToFill()
            .padding()
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
    }
    
    var welcomeText: some View {
        Text("Welcome Muggle!")
            .font(.custom("AmaticSC-Bold", size: animate ? 50 : 45))
            .padding(.horizontal, animate ? 10 : 50)
            .scaleEffect(animate ? 1.2 : 1.0)
            .offset(x: animate ? -5 : 0)
    }
    
    var welcomeTextField: some View {
        TextField("Type your name here..", text: $playerName)
            .focused($playerInFocus)
            .font(.custom("AmaticSC-Regular", size: 30))
            .multilineTextAlignment(.center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .submitLabel(.next)
            .onSubmit {
                guard playerName.isEmpty == false else { return }
            }
    }
    
    var saveButton: some View {
        Button(
            action: {
                if playerName.count <= 3 {
                    alertType = .tooShort
                }
                else {
                    playerNameTyped()
                }
            },
            label: {
            Text("Save")
                .font(.custom("AmaticSC-Bold", size: 30))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.gray)
                .cornerRadius(15)
        })
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
    
    func playerNameTyped() {
        currentPlayerName = playerName
        currentPlayerNameTyped = true
    }
}

