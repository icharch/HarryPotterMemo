//
//  SingleCardPhotoView.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 16/03/2023.
//

import SDWebImageSwiftUI
import SwiftUI

class SingleCardViewModel: ObservableObject {
    var photoURL: URL?

    init(photoURL: String) {
        self.photoURL = URL(string: photoURL)
    }
}

struct SingleCardPhotoView: View {
    @ObservedObject var viewModel: SingleCardViewModel
    @Binding var degree : Double

// MARK: BODY
    
    var body: some View {
        ZStack {
            cardPhoto
        }   
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct SingleCardPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardPhotoView(viewModel: SingleCardViewModel(photoURL: "https://url"),
                            degree: .constant(0))
    }
}

// MARK: COMPONENTS

private extension SingleCardPhotoView {
    var cardPhoto: some View {
        WebImage(url: viewModel.photoURL)
            .onSuccess { _, _, _ in }
            .resizable()
            .scaledToFill()
            .frame(width: 160, height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .gray, radius: 3, x: 0, y: 3)
    }
}
