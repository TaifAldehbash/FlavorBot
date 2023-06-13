//
//  OnboardingView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 11/06/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    var subviews = [
        UIHostingController(rootView: OnboardIllistrationView(imageString: "Onboard1")),
        UIHostingController(rootView: OnboardIllistrationView(imageString: "Onboard2")),
        UIHostingController(rootView: OnboardIllistrationView(imageString: "Onboard3"))
    ]
    
    var titles = ["Make your favorite recipes", "Save your recipes", "Join us!"]
    var captions = [
        "tell us what ingredients you have and we will show you what you can make.",
        "Save your favourite recipes to enjoy them again later.",
        "Sign up to get the full experience of FoodBot."]
    
    @State var last : Bool = false
    
    @State var currentPageIndex = 0
    //Navigation Router
    @StateObject var viewRouter : ViewRouter
    
    var body: some View {
        ZStack{
            
            VStack {
                PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                    .frame(width: width(w: 422), height: height(h: 422))
                
                Group {
                    Text(titles[currentPageIndex])
                        .font(.custom("Poppins Bold", size: 45))
                        .foregroundColor(Color(hex: "FFFFFF"))
                        .tracking(-1.8)
                        .multilineTextAlignment(.center)
                    
                    Text(captions[currentPageIndex])
                        .font(.custom("Poppins Regular", size: 18))
                        .foregroundColor(Color(hex: "FFFFFF"))
                        .frame(width: width(w: 300), height: height(h: 50), alignment: .leading)
                        .lineLimit(nil).multilineTextAlignment(.center)
                    
                }
                
                PageControl(numberOfpages: subviews.count, currentPageIndex: $currentPageIndex)
                HStack {
                    Spacer()
                    Button(action: {
                        if self.currentPageIndex == self.subviews.count-1 {
                            viewRouter.currentPage = .SignIn
                        }else{
                            //show Get Started button at last slide
                            if self.currentPageIndex + 1 == self.subviews.count-1{
                                last.toggle()
                            }
                            self.currentPageIndex += 1
                        }
                    }) {
                        if !last{
                            NextButtonContent()
                        }else{
                            GetStartedButtonContent()
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 0, leading: width(w: 2), bottom: 0, trailing: width(w: 32)))
            }.frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
                .background(Color("MidPurple"))
        }.ignoresSafeArea()//.overlay(LaunchView())
    }
}

struct NextButtonContent: View {
    
    var body: some View {
        ZStack{
            
            //Rectangle
            RoundedRectangle(cornerRadius: 27.2)
                .fill(Color(hex: "455A64"))
                .frame(width: width(w: 68), height: height(h: 68))
                .rotationEffect(.degrees(0))
                .shadow(color: Color(#colorLiteral(red: 0.8627451062202454, green: 0.2666666805744171, blue: 0.20000000298023224, alpha: 0.20000000298023224)), radius:27.19999885559082, x:0, y:6.799999713897705)
            //arrow-right
            RightArrow().fill(Color(hex: "FFFFFF"))
                .frame(width: width(w: 13.22), height: height(h: 21.64))
                .rotationEffect(.degrees(0))
        }
    }
}

struct GetStartedButtonContent: View {
    
    var body: some View {
        ZStack{
            //Rectangle 2
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(hex: "455A64"))
                .frame(width: width(w: 314), height: height(h: 70))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5199999809265137)), radius:34, x:0, y:4)
            //Get started
            Text("Get started").font(.custom("Poppins Bold", size: 19)).foregroundColor(Color(hex: "FFFFFF")).multilineTextAlignment(.center)
            //Available in iOS 14 only
                .textCase(.uppercase)
            
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewRouter: ViewRouter())
    }
}
