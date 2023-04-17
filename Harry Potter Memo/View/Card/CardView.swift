//
//  CardView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 29/03/2023.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel: CardViewModel

    @State var backDegree: Double = 0
    @State var frontDegree: Double = -360
    @State var durationAndDelay: CGFloat = 0.3

// MARK: BODY
    
    var body: some View {
        ZStack {
            if viewModel.isFlipped {
                switch viewModel.cardType {
                case .description:
                    SingleCardInfoView(
                        viewModel: .init(
                            name: viewModel.name,
                            house: viewModel.house,
                            patronus: viewModel.patronus,
                            ancestry: viewModel.ancestry
                        ),
                        degree: $frontDegree
                    )
                case .image:
                    SingleCardPhotoView(
                        viewModel: .init(
                            photoURL: viewModel.imageURL),
                        degree: $frontDegree
                    )
                }
            } else {
                CardBackView(degree: $backDegree)
            }
        }
        .onTapGesture {
            guard !viewModel.isMatched else { return }
            viewModel.cardFlip()
        }
    }

        
        
        

    
            

//            if viewModel.isFlipped {
//                withAnimation(.linear(duration: durationAndDelay)) {
//                    backDegree = 90
//                }
//                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
//                    frontDegree = 0
//                }
//            }
//            else {
//                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
//                    frontDegree = -90
//                }
//                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
//                    backDegree = 0
//                }
            
}
