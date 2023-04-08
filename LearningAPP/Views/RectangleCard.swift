//
//  RectangleCard.swift
//  LearningAPP
//
//  Created by UKESH KUMAR on 08/04/23.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    var body: some View {
        Rectangle()
            .foregroundColor(Color.green)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
