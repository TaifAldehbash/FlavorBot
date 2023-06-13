//
//  OnboardIllistrationView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 11/06/2023.
//

import SwiftUI

struct OnboardIllistrationView: View {
    
    var imageString: String
    
    var body: some View {
        ZStack{
            Color("MidPurple")
            Image(imageString)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.black.opacity(0))
                .clipped()
        }
        
    }
}

struct OnboardIllistrationView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardIllistrationView(imageString: "Onboard1")
    }
}
