//
//  SignUpView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 14/06/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewRouter : ViewRouter
    
    var body: some View {
        Text("Sign up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewRouter: ViewRouter())
    }
}
