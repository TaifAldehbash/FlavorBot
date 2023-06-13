//
//  MotherView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 13/06/2023.
//

import SwiftUI

struct MotherView: View {
    //Navigation Router
    @StateObject var viewRouter : ViewRouter
    
    var body: some View {
        VStack{
            switch viewRouter.currentPage {
                case .Launch : LaunchView(viewRouter: viewRouter)
                case .OnBoard : OnboardingView(viewRouter: viewRouter)
                case .SignIn : SignInView(viewRouter: viewRouter)
                case .Home : HomeView(viewRouter: viewRouter)
                default:
                    HomeView(viewRouter: viewRouter)
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}

enum Page {
    case Launch
    case OnBoard
    case SignIn
    case Home
}

class ViewRouter : ObservableObject {
    @Published var currentPage: Page = .Launch
    
}
