//
//  HomeView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 09/06/2023.
//

import SwiftUI

struct HomeView: View {
    //Navigation Router
    @StateObject var viewRouter : ViewRouter
    
    var body: some View {
        ZStack{
            Text("Home!")
        }.ignoresSafeArea()
        //.overlay(LaunchView())
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
    }
}
