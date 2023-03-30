//
//  CardView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 29/03/2023.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel = CardViewModel()
    @State var card: Card

    var didReverse: (() -> Void)
    var body: some View {
        ZStack {
            switch card {
            case let .description(model):
                SingleCardInfoView(viewModel: .init(card: model), degree: $viewModel.frontDegree)
            case let .image(model):
                SingleCardPhotoView(viewModel: .init(card: model), degree: $viewModel.frontDegree)
            }
            CardBackView(degree: $viewModel.backDegree)
        }
        .onTapGesture {
            viewModel.flipCard()
            didReverse()
        }
    }


}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: .image(CardModel(id: "dd925874-e800-4eb4-9f0d-4d0fed15634b", name: "Arthur Weasley", house: "Gryffindor", ancestry: .pureBlood, patronus: "weasel", image: "https://ik.imagekit.io/hpapi/arthur.jpg")))
//    }
//}
//
//
