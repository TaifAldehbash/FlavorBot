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
    //DB
    @ObservedObject var sessionSession = FoodBotDB()
    
    @State private var email : String = ""
    @State private var pass : String = ""
    @State private var emailMsg : String = "Please enter a valid email"
    @State private var invalidEmail : Bool = false
    @State private var invalidPass : Bool = false
    @State private var signinCheck : Bool = false
    
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    ZStack{
                        Blop1().frame(width: width(w: 271), height: height(h: 224.96)).foregroundColor(Color("MidPurple"))
                        VStack{
                            Logo().frame(width: width(w: 40.81), height: height(h: 40.74)).foregroundColor(Color("LightGreen"))
                            TextLogo().frame(width: width(w: 189), height: height(h: 38.23)).foregroundColor(Color("LightGreen"))
                        }.padding(EdgeInsets(top: height(h: 60), leading: 0, bottom: 0, trailing: width(w: 35)))
                    }
                    Spacer()
                }
                Spacer()
                //Sign In
                Text("Sign In").font(.custom("Poppins Bold", size: 45)).fontWeight(.heavy).foregroundColor(Color("DarkPurple")).tracking(-1.35).multilineTextAlignment(.center)
                //Email Group
                Group{
                    //Email
                    HStack{
                        Text("Email").font(.custom("Poppins Medium", size: 20)).foregroundColor(Color("DarkGrey")).padding(EdgeInsets(top: height(h: 34), leading: width(w: 46), bottom: 0, trailing: 0))
                        Spacer()
                    }
                    TextField("Ex.: Sara@mail.com", text: $email)
                        .onChange(of: email, perform: { e in
                            checkEmail(strToValidate: e)
                        })
                        .font(.custom("Poppins Medium", size: 20))
                        .textFieldStyle(CustomTextField())
                        .frame(width: width(w: 331), height: height(h: 60))
                        .autocapitalization(.none)
                    //Invalid Email Error msg
                    HStack{
                       // if (self.invalidEmail || self.signinErr){
                            Text(emailMsg)
                                .font(.custom("Poppins Medium", size: 20))
                                .foregroundColor(Color("DarkRed"))
                                .padding(EdgeInsets(top: 0, leading: width(w: 46), bottom: 0, trailing: 0)).isHidden(!invalidEmail)
                        //}
                        Spacer()
                    }
                }.padding(0)
                //Pass Group
                Group{
                    //Password
                    HStack{
                        Text("Password").font(.custom("Poppins Medium", size: 20)).foregroundColor(Color("DarkGrey")).padding(EdgeInsets(top: height(h: 10), leading: width(w: 46), bottom: 0, trailing: 0))
                        Spacer()
                    }
                    SecureField("Password", text: $pass)
                        .onChange(of: pass, perform: { newValue in
                        checkPass()
                    })
                        .font(.custom("Poppins Medium", size: 20))
                        .textFieldStyle(CustomTextField())
                        .frame(width: width(w: 331), height: height(h: 60))
                        .autocapitalization(.none)
                    //Invalid Pass Error msg
                    HStack{
                        Text("Please enter a valid password")
                            .font(.custom("Poppins Medium", size: 20))
                            .foregroundColor(Color("DarkRed"))
                            .padding(EdgeInsets(top: 0, leading: width(w: 46), bottom: height(h: 29), trailing: 0))
                            .isHidden(!invalidPass)
                        Spacer()
                    }
                }.padding(0)
                //Sign in button
                Button("Sign In", action: {signin()})
                    .font(.custom("Poppins Medium", size: 24))
                    .fontWeight(.heavy).foregroundColor(Color("White")).buttonStyle(CustomButton())
                    .frame(width: width(w: 314), height: height(h: 70))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: height(h: 25), trailing: 0))
                HStack{
                    //Sign up button
                    Button(action: {
                        viewRouter.currentPage = .SignUp
                    }, label: {
                        Text("Sign Up").font(.custom("Roboto Bold", size: 20)).underline().foregroundColor(Color("DarkPurple"))
                    })
                    Text("Or continue as a").font(.custom("Roboto Bold", size: 20)).foregroundColor(Color("DarkPurple"))
                    //Guist Button
                    Button(action: {
                        viewRouter.currentPage = .Home
                    }, label: {
                        Text("Guist").font(.custom("Roboto Bold", size: 20)).underline().foregroundColor(Color("DarkPurple"))
                    })
                }
                HStack{
                    Spacer(minLength: width(w: 300))
                        Blop3().frame(width: width(w: 251), height: height(h: 198)).foregroundColor(Color("LightPurple"))
                }
            }
        }.frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            .background(Color("Grey")).ignoresSafeArea()
    }
    
    //Check email format
    func checkEmail(strToValidate: String) {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1
        
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
        
        self.invalidEmail = !emailValidationPredicate.evaluate(with: strToValidate) || strToValidate == ""  // 3
        self.emailMsg = self.invalidEmail ? "Please enter a valid email" : ""
    }
    
    //Check Pass Format
    func checkPass() {
        
        if pass.isEmpty {
            invalidPass = true
        }else{
            invalidPass = false
        }
    }
    
    //Sign in user through Firebase Auth
    func signin(){
        print("\n\n\nSign in!!\n\n\n")
        if (!invalidEmail && !invalidPass && !email.isEmpty && !pass.isEmpty){
            self.signinCheck = self.sessionSession.signIn(email: email.lowercased(), pass: pass)
            self.invalidEmail = !self.signinCheck
            self.emailMsg = self.invalidEmail ? "Email or password is incorrect" : ""
            if (self.signinCheck) {
                viewRouter.currentPage = .Home
            }
        }else{
            
            print("invalid sign in")
            self.emailMsg = "Email or password is incorrect"
            self.invalidEmail = true
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewRouter: ViewRouter())
    }
}
