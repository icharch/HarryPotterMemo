//
//  CardViewModel.swift
//  Harry Potter Memo
//
//  Created by Irmina Charchuta on 30/03/2023.
//

import Foundation

class CardViewModel: ObservableObject {
 
    @Published var isFlipped: Bool = false
    @Published var backDegree: Double = 0.0
    @Published var frontDegree: Double = -90.0
    @Published var durationAndDelay: CGFloat = 0.3
    
    
    // MARK: FUNCTIONS

    func flipCard() {
        isFlipped = !isFlipped
    }
}




