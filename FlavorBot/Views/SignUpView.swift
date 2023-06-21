//
//  SignUpView.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 14/06/2023.
//

import SwiftUI

struct SignUpView: View {
    //Navigation Router
    @StateObject var viewRouter : ViewRouter
    
    //DB
    @ObservedObject var sessionSession = FoodBotDB()
    
    @State private var email : String = ""
    @State private var name : String = ""
    @State private var pass : String = ""
    @State private var nameMsg : String = "Please enter a valid name"
    @State private var invalidEmail : Bool = false
    @State private var invalidName : Bool = false
    @State private var invalidPass : Bool = false
    @State private var signupErr : Bool = false
    
    var body: some View {
        ZStack{
            
            VStack{
                //Logo
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
                Text("Sign Up").font(.custom("Poppins Bold", size: 45)).fontWeight(.heavy).foregroundColor(Color("DarkPurple")).tracking(-1.35).multilineTextAlignment(.center)
                //Name Group
                Group{
                    //Name
                    HStack{
                        Text("Name").font(.custom("Poppins Medium", size: 20)).foregroundColor(Color("DarkGrey")).padding(EdgeInsets(top: height(h: 0), leading: width(w: 46), bottom: 0, trailing: 0))
                        Spacer()
                    }
                    TextField("Ex.: Sara", text: $name)
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
                        Text(nameMsg)
                            .font(.custom("Poppins Medium", size: 20))
                            .foregroundColor(Color("DarkRed"))
                            .padding(EdgeInsets(top: 0, leading: width(w: 46), bottom: 0, trailing: 0)).isHidden(!invalidName)
                        //}
                        Spacer()
                    }
                }.padding(0)
                //Email Group
                Group{
                    //Email
                    HStack{
                        Text("Email").font(.custom("Poppins Medium", size: 20)).foregroundColor(Color("DarkGrey")).padding(EdgeInsets(top: 0, leading: width(w: 46), bottom: 0, trailing: 0))
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
                        Text("Please enter a valid email")
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
                        Text("Password").font(.custom("Poppins Medium", size: 20)).foregroundColor(Color("DarkGrey")).padding(EdgeInsets(top:0, leading: width(w: 46), bottom: 0, trailing: 0))
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
                            .padding(EdgeInsets(top: 0, leading: width(w: 46), bottom: height(h: 10), trailing: 0))
                            .isHidden(!invalidPass)
                        Spacer()
                    }
                }.padding(0)
                //Sign in button
                Button("Sign Up", action: {signup()})
                    .font(.custom("Poppins Medium", size: 24))
                    .fontWeight(.heavy).foregroundColor(Color("White")).buttonStyle(CustomButton())
                    .frame(width: width(w: 314), height: height(h: 70))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: height(h: 15), trailing: 0))
                
                HStack{
                    Spacer(minLength: width(w: 300))
                    ZStack{
                        Blop3().frame(width: width(w: 251), height: height(h: 198)).foregroundColor(Color("LightPurple"))
                        //Sign in button
                        Button(action: {
                            viewRouter.currentPage = .SignIn
                        }, label: {
                            Text("Sign In").font(.custom("Roboto Bold", size: 24)).underline().foregroundColor(Color("DarkPurple"))
                        }).padding(EdgeInsets(top: 0, leading: 0, bottom: height(h: 15), trailing: width(w: 34)))
                    }
                }
            }
        }.frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            .background(Color("Grey")).ignoresSafeArea()
    }
    
    //Check Pass Format
    func checkName() {
        
        if name.isEmpty || name.count <= 2{
            self.invalidName = true
        }else{
            self.invalidName = false
        }
    }
    
    //Check email format
    func checkEmail(strToValidate: String) {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1
        
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
        
        self.invalidEmail = !emailValidationPredicate.evaluate(with: strToValidate) || strToValidate == ""  // 3
        self.nameMsg = self.invalidEmail ? "Please enter a valid name" : ""
    }
    
    //Check Pass Format
    func checkPass() {
        
        if pass.isEmpty || pass.count < 8{
            invalidPass = true
        }else{
            invalidPass = false
        }
    }
    
    //Sign in user through Firebase Auth
    func signup(){
        print("\n\n\nSign up!!\n\n\n")
        if (!invalidEmail && !invalidPass && !invalidName && !email.isEmpty && !pass.isEmpty && !name.isEmpty){
            
            self.signupErr = !self.sessionSession.signUp(name: name, email: email.lowercased(), pass: pass)
            self.invalidName = self.signupErr
            self.nameMsg = self.invalidName ? "Email is already registered" : ""
            if (!self.signupErr) {viewRouter.currentPage = .Home}
        }else{
            
            print("invalid sign up")
            self.invalidEmail = true
            self.invalidName = true
            self.invalidPass = true
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewRouter: ViewRouter())
    }
}
