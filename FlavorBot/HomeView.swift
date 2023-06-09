//
//  HomeView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 09/06/2023.
//

import SwiftUI
import Inject

struct HomeView: View {
    @ObservedObject var inject = Inject.observer
    var body: some View {
        ZStack{
            Text("Hello!")
        }.ignoresSafeArea()
            .overlay(LaunchView())
            .enableInjection()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
