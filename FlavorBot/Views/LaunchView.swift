//
//  LaunchView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 06/06/2023.
//

import SwiftUI
import Inject

struct LaunchView: View {
    
    //Animation properties
    @State var startAnimation: Bool = false
    @State var logoAnimation: Bool = false
    @State var endAnimation: Bool = false
    @State var finishAnimation: Bool = false
    @ObservedObject var inject = Inject.observer
    var body: some View {
        if !finishAnimation{
            HStack{
                ZStack{
                    Color("MidPurple")
                    Group{
                    VStack{
                        Logo().frame(width: width(w: 110), height: height(h: 110)).scaleEffect(logoAnimation ? 1:0).foregroundColor(Color(hex: "AED768")).padding(EdgeInsets(top: 0, leading: 0, bottom: height(h: 20), trailing: 0))
                        TextLogo().trim(from: 0, to: startAnimation ? 1 : 0 ).frame(width: width(w: 290), height: height(h: 90)).foregroundColor(Color(hex: "AED768"))
                    }
                    }.frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
                        .scaleEffect(endAnimation ? 0.15:0.9)
                    
                }.ignoresSafeArea()
                    .onAppear{
                        //Start animation
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.15){
                            //Start logo animation
                            withAnimation(.spring().delay(0.15)) {
                                logoAnimation.toggle()
                            }
                            //start text logo animation
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 3.05, blendDuration: 1.05).delay(0.3)){
                                startAnimation.toggle()
                            }
                            //End animation
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.5, blendDuration: 1.05).delay(3.5)){
                                endAnimation.toggle()
                            }
                            
                            //Finish launch screen
                            DispatchQueue.main.asyncAfter(deadline: .now()+5){
                                withAnimation(){
                                    finishAnimation.toggle()
                                }
                            }
                        }
                        
                    }
            }.enableInjection()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
































