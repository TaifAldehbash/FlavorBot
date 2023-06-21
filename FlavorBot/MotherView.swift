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
    @ObservedObject var sessionStore = FoodBotDB()
    
    init(viewRouter : ViewRouter) {
        self._viewRouter = StateObject<ViewRouter>(wrappedValue: viewRouter)
        sessionStore.listen()
    }
    
    var body: some View {
        VStack{
            //if !self.sessionStore.isAnon {
                switch viewRouter.currentPage {
                    case .Launch : LaunchView(viewRouter: viewRouter)
                    case .OnBoard : OnboardingView(viewRouter: viewRouter)
                    case .SignIn : SignInView(viewRouter: viewRouter)
                    case .SignUp : SignUpView(viewRouter: viewRouter)
                    case .Home : HomeView(viewRouter: viewRouter)
                    default:
                        HomeView(viewRouter: viewRouter)
                }
            //}else{
                //SignInView(viewRouter: viewRouter)
            //}
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
    case SignUp
    case Home
}

class ViewRouter : ObservableObject {
    @Published var currentPage: Page = .Home//.Launch
    
}
