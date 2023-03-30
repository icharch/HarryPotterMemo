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
    @State var showAlert: Bool = false
    @State var alertType: MyAlerts? = nil
    @AppStorage("name") var currentPlayerName: String = ""
    @AppStorage("name_typed") var currentPlayerNameTyped: Bool = false

// MARK: ALERT TYPES
    
    enum MyAlerts {
  //      case success
        case error
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
        .alert(isPresented: $showAlert, content: getAlert)
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
                if playerName.count < 2 {
                    alertType = .error
                }
                showAlert.toggle()
                playerNameTyped()
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
}

// MARK: FUNCTIONS

extension WelcomeView {
    
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
    
    func getAlert() -> Alert {
        switch alertType {
        case .error:
            return Alert(title: Text("Your name is too short.. Please type again!"))
        case .none:
            return Alert(title: Text("Error"))
        }
    }
    
    func playerNameTyped() {
        currentPlayerName = playerName
        currentPlayerNameTyped = true
    }
}
