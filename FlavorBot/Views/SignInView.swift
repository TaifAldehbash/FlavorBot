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
    
    @State private var email : String = ""
    @State private var pass : String = ""
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    ZStack{
                        Blop1().frame(width: width(w: 271), height: height(h: 224.96)).foregroundColor(Color("MidPurple"))
                        VStack{
                            Logo().frame(width: width(w: 40.81), height: height(h: 40.74)).foregroundColor(Color("LightGreen"))
                            TextLogo().frame(width: width(w: 189), height: height(h: 38.23)).foregroundColor(Color("LightGreen"))
                        }.padding(EdgeInsets(top: height(h: 20), leading: 0, bottom: 0, trailing: width(w: 20)))
                    }
                    Spacer()
                }
                Spacer()
                //Sign In
                Text("Sign In").font(.custom("Poppins Bold", size: 45)).fontWeight(.heavy).foregroundColor(Color("DarkPurple")).tracking(-1.35).multilineTextAlignment(.center)
                //Email
                HStack{
                    Text("Email").font(.custom("Poppins Medium", size: 20)).foregroundColor(Color("DarkGrey")).padding(EdgeInsets(top: height(h: 44), leading: width(w: 46), bottom: 0, trailing: 0))
                    Spacer()
                }
                TextField("Ex.: Sara@mail.com", text: $email).font(.custom("Poppins Medium", size: 20)).textFieldStyle(CustomTextField()).frame(width: width(w: 331), height: height(h: 60))
                //Password
                HStack{
                    Text("Password").font(.custom("Poppins Medium", size: 20)).foregroundColor(Color("DarkGrey")).padding(EdgeInsets(top: height(h: 10), leading: width(w: 46), bottom: 0, trailing: 0))
                    Spacer()
                }
                SecureField("Password", text: $pass).font(.custom("Poppins Medium", size: 20)).textFieldStyle(CustomTextField()).frame(width: width(w: 331), height: height(h: 60)).padding(EdgeInsets(top: 0, leading: 0, bottom: height(h: 49), trailing: 0))
                //Sign in button
                Button("Sign In", action: signin).font(.custom("Poppins Medium", size: 24)).fontWeight(.heavy).foregroundColor(Color("White")).buttonStyle(CustomButton()).frame(width: width(w: 314), height: height(h: 70))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: height(h: 25), trailing: 0))
                HStack{
                    Spacer(minLength: width(w: 300))
                    ZStack{
                        Blop3().frame(width: width(w: 251), height: height(h: 198)).foregroundColor(Color("LightPurple"))
                        //Sign up button
                        Button(action: {
                            viewRouter.currentPage = .SignUp
                        }, label: {
                            Text("Sign Up").font(.custom("Roboto Bold", size: 24)).underline().foregroundColor(Color("DarkPurple")).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: width(w: 31)))
                        })
                    }
                }
            }
        }.frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            .background(Color("Grey")).ignoresSafeArea()
    }
    
    func signin(){
        print("\n\n\nSign in!!\n\n\n")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewRouter: ViewRouter())
    }
}
