//
//  LoggedInView.swift
//  SportsTribeAssignment
//
//  Created by Kevin Thomas on 30/06/23.
//

import SwiftUI
import FirebaseAuth

struct LoggedInView: View {
    
    @State var logOut : Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("You are logged in")
                Button {
                    do{
                        try Auth.auth().signOut()
                        logOut.toggle()
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    Text("Logout")
                }
                
                NavigationLink(destination: ContentView()
                                                .navigationBarBackButtonHidden(true)
                                                .navigationBarHidden(true),
                               isActive: $logOut) {
                    Text("")
                }
                .hidden()
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}
