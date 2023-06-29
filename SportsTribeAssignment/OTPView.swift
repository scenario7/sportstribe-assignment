//
//  OTPView.swift
//  SportsTribeAssignment
//
//  Created by Kevin Thomas on 29/06/23.
//

import SwiftUI
import Combine
import FirebaseAuth

struct OTPView: View {
    
    @State var oneTimePassword : String = ""
    let otpLimit = 10
    
    var verificationID : String
    var phoneNumber : String
    
    @State var loggedIn : Bool = false
    
    @State var loading = false
    
    @State var isAnimating = false
    
    var foreverAnimation: Animation {
            Animation.linear(duration: 2.0)
                .repeatForever(autoreverses: false)
        }
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black.ignoresSafeArea()
                Circle()
                    .foregroundColor(.blue)
                    .blur(radius: 100)
                    .offset(x:-100,y:-400)
                Circle()
                    .foregroundColor(.green)
                    .blur(radius: 100)
                    .offset(x:100,y:-400)
                VStack(alignment:.center, spacing: 20) {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.white.opacity(0.5))
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .imageScale(.large)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(width: 60, height: 60)
                    Text("Enter OTP")
                        .font(.custom("Lufga", size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Text("Enter the One Time Password sent to \(phoneNumber)")
                        .font(.custom("Lufga", size: 15))
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                    ZStack {
                        HStack(spacing:9) {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                            .frame(width: 40)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                                .frame(width: 40)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                                .frame(width: 40)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                                .frame(width: 40)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                                .frame(width: 40)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                                .frame(width: 40)
                        }
                        TextField("••••••", text: $oneTimePassword.max(6))
                        .multilineTextAlignment(.leading)
                        .offset(x:7.5)
                        .textFieldStyle(.plain)
                        .font(.system(size: 40))
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
                        .tracking(24.5)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.phonePad)
                        
                    }
                    .frame(width: 200, height: 40)
                    
                    Button {
                        loading.toggle()
                        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: oneTimePassword)
                        
                        Auth.auth().signIn(with: credential) { result, error in
                            if let error = error {
                                print(error.localizedDescription)
                                loading.toggle()
                            }
                            loggedIn.toggle()
                            loading.toggle()
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(oneTimePassword.trimmingCharacters(in: .whitespacesAndNewlines).count != 6 ? .gray : .blue)
                                .shadow(color: oneTimePassword.trimmingCharacters(in: .whitespacesAndNewlines).count != 6 ? .gray : .blue, radius: 10)
                            if loading {
                                Image(systemName: "circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .frame(width: isAnimating ? 40 : 10)
                                    .task {
                                        withAnimation(.easeInOut(duration: 0.5).repeatCount(20).repeatForever(autoreverses:true)){
                                            isAnimating.toggle()
                                        }
                                    }
                            } else {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 50)
                    }
                    .disabled(oneTimePassword.trimmingCharacters(in: .whitespacesAndNewlines).count != 6 ? true : false)
                    NavigationLink(
                        destination: LoggedInView()
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true),
                        isActive: $loggedIn) {
                        Text("")
                    }
                    .hidden()
                    Spacer()
                    Text("Phone Authentication Powered by Firebase")
                        .foregroundColor(.gray)
                        .font(.custom("Lufga", size: 15))
                }
                .padding()
            }
        }
    }
    
    func limitText(_ upper: Int) {
            if oneTimePassword.count > upper {
                oneTimePassword = String(oneTimePassword.prefix(upper))
            }
        }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView(verificationID: "", phoneNumber: "")
    }
}


//extension for limiting the number of characters in a textfield

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
