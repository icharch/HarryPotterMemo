//
//  CardBackView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 16/03/2023.
//

import SwiftUI

struct CardBackView: View {

    @Binding var degree : Double

// MARK: BODY

    var body: some View {
        ZStack {
            cardBack
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
        
    }
}

struct CardBackView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView(degree: .constant(0))
    }
}

// MARK: COMPONENTS

private extension CardBackView {
    var cardBack: some View {
        VStack {
            Image("witch-hat")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            HStack {
                Text("Harry Potter")
                Text("Memo")
                    .foregroundColor(.red)
            }
                .font(.custom("AmaticSC-Bold", size: 25))
        }
        .multilineTextAlignment(.center)
        .frame(width: 160, height: 160)
        .clipShape(Rectangle())
        .background(.ultraThickMaterial)
        .cornerRadius(15)
        .shadow(color: .gray, radius: 3, x: 0, y: 3)
    }
}

