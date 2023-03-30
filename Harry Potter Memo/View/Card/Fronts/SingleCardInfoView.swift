//
//  SingleCardInfoView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 16/03/2023.
//

import SwiftUI

struct SingleCardInfoView: View {
    // MARK: BODY
    @ObservedObject var viewModel: SingleCardInfoViewModel
    @Binding var degree : Double

    var body: some View {
    ZStack {
            cardInfo
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct SingleCardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardInfoView(
            viewModel: SingleCardInfoViewModel(card: .init(id: "", name: "", house: "Gryffindor", ancestry: .halfBlood, patronus: "stag", image: "https://ik.imagekit.io/hpapi/harry.jpg")), degree: .constant(0))
    }
}

// MARK: COMPONENTS

class SingleCardInfoViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var house: String = ""
    @Published var patronus: String = ""
    @Published var ancestry: String = ""

    init(card: CardModel) {
        name = card.name
        house = card.house
        patronus = card.patronus
        ancestry = card.ancestry.description
    }
}

private extension SingleCardInfoView {

    var cardInfo: some View {
        VStack(spacing: 5) {
            HStack {
                if !viewModel.name.isEmpty {
                    Text("Name:")
                    Text(viewModel.name)
                        .foregroundColor(.red)
                }
            }
            HStack {
                if !viewModel.house.isEmpty {
                    Text("House:")
                    Text(viewModel.house)
                        .foregroundColor(.red)
                }
            }
            HStack {
                if !viewModel.ancestry.isEmpty {
                    Text("Ancestry:")
                    Text(viewModel.ancestry)
                        .foregroundColor(.red)
                }
            }
            HStack {
                if !viewModel.patronus.isEmpty {
                    Text("Patronus:")
                    Text(viewModel.patronus)
                        .foregroundColor(.red)
                }
            }
        }
        .font(.custom("AmaticSC-Bold", size: 22))
        .multilineTextAlignment(.center)
        .frame(width: 160, height: 160)
        .clipShape(Rectangle())
        .background(.ultraThickMaterial)
        .cornerRadius(15)
        .shadow(color: .gray, radius: 3, x: 0, y: 3)
    }
}
