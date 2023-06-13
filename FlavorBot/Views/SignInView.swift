//
//  SignInView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 13/06/2023.
//

import SwiftUI

struct SignInView: View {
    //Navigation Router
    @StateObject var viewRouter : ViewRouter
    
    var body: some View {
        Text("Sign in!")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewRouter: ViewRouter())
    }
}
