//
//  ContentView.swift
//  SportsTribeAssignment
//
//  Created by Kevin Thomas on 29/06/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State var mobileNumber : String = ""
    
    @State var showVerify = false
    
    @State var verificationID = ""
    
    @State var showProgress = false
    
    @State var loading = false
    
    @State var isAnimating = false
    
    @State private var countryCode = "91"
    
    let countryDictionary  = ["AF":"93","AL":"355","DZ":"213","US":"1",
                              "AD":"376","AO":"244","AI":"1","AG":"1","AR":"54",
                              "AM":"374","AW":"297","AU":"61","AT":"43","AZ":"994",
                              "BS":"1","BH":"973","BD":"880","BB":"1","BY":"375",
                              "BE":"32","BZ":"501","BJ":"229","BM":"1","BT":"975",
                              "BA":"387","BW":"267","BR":"55","IO":"246","BG":"359",
                              "BF":"226","BI":"257","KH":"855","CM":"237","CA":"1",
                              "CV":"238","KY":"345","CF":"236","TD":"235","CL":"56","CN":"86",
                              "CX":"61","CO":"57","KM":"269","CG":"242","CK":"682","CR":"506",
                              "HR":"385","CU":"53","CY":"537","CZ":"420","DK":"45","DJ":"253",
                              "DM":"1","DO":"1","EC":"593","EG":"20","SV":"503","GQ":"240",
                              "ER":"291","EE":"372","ET":"251","FO":"298","FJ":"679","FI":"358",
                              "FR":"33","GF":"594","PF":"689","GA":"241","GM":"220","GE":"995",
                              "DE":"49","GH":"233","GI":"350","GR":"30","GL":"299","GD":"1",
                              "GP":"590","GU":"1","GT":"502","GN":"224","GW":"245","GY":"595","HT":"509",
                              "HN":"504","HU":"36","IS":"354","IN":"91","ID":"62","IQ":"964",
                              "IE":"353","IL":"972","IT":"39","JM":"1","JP":"81","JO":"962",
                              "KZ":"77","KE":"254","KI":"686","KW":"965","KG":"996","LV":"371",
                              "LB":"961","LS":"266","LR":"231","LI":"423","LT":"370","LU":"352",
                              "MG":"261","MW":"265","MY":"60","MV":"960","ML":"223",
                              "MT":"356","MH":"692","MQ":"596","MR":"222","MU":"230","YT":"262",
                              "MX":"52","MC":"377","MN":"976", "ME":"382","MS":"1","MA":"212",
                              "MM":"95","NA":"264","NR":"674","NP":"977","NL":"31","NC":"687",
                              "NZ":"64","NI":"505","NE":"227","NG":"234","NU":"683",
                              "NF":"672","MP":"1","NO":"47","OM":"968","PK":"92","PW":"680",
                              "PA":"507","PG":"675","PY":"595","PE":"51","PH":"63","PL":"48",
                              "PT":"351","PR":"1","QA":"974","RO":"40","RW":"250","WS":"685",
                              "SM":"378","SA":"966","SN":"221","RS":"381","SC":"248",
                              "SL":"232","SG":"65","SK":"421","SI":"386","SB":"677",
                              "ZA":"27","GS":"500","ES":"34","LK":"94","SD":"249","SR":"597",
                              "SZ":"268","SE":"46","CH":"41","TJ":"992","TH":"66","TG":"228",
                              "TK":"690","TO":"676","TT":"1","TN":"216","TR":"90",
                              "TM":"993","TC":"1","TV":"688","UG":"256","UA":"380",
                              "AE":"971","GB":"44","AS":"1","UY":"598","UZ":"998",
                              "VU":"678","WF":"681","YE":"967","ZM":"260",
                              "ZW":"263","BO":"591","BN":"673","CC":"61",
                              "CD":"243","CI":"225","FK":"500","GG":"44",
                              "VA":"379","HK":"852","IR":"98","IM":"44",
                              "JE":"44","KP":"850","KR":"82","LA":"856",
                              "LY":"218","MO":"853","MK":"389","FM":"691",
                              "MD":"373","MZ":"258","PS":"970","PN":"872",
                              "RE":"262","RU":"7","BL":"590","SH":"290","KN":"1",
                              "LC":"1","MF":"590","PM":"508","VC":"1","ST":"239",
                              "SO":"252","SJ":"47","SY":"963","TW":"886","TZ":"255",
                              "TL":"670","VE":"58","VN":"84","VG":"284","VI":"340"]
    
    var body: some View {
        NavigationView {
            ZStack(alignment:.center) {
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
                        Image(systemName: "lock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 60, height: 60)
                    Text("Enter Mobile Number")
                        .font(.custom("Lufga", size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    HStack {
                        Menu {
                            ForEach(countryDictionary.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                Button(action: {
                                    countryCode = value
                                }) {
                                    Text("\(key) (+\(value))")
                                }
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white.opacity(0.5))
                                HStack {
                                    Image(systemName: "globe")
                                    Text("\(countryCode)")
                                }
                                .foregroundColor(.black)
                            }
                            .frame(width:90, height: 40)
                        }
                        .padding()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                            TextField("99xxx xxx64", text: $mobileNumber)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(.plain)
                                .fontDesign(.monospaced)
                                .foregroundColor(.white)
                                .keyboardType(.phonePad)
                                .textContentType(.telephoneNumber)
                            
                        }
                        .frame(width: 200, height: 40)
                    }
                    
                    Button {
                        loading.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0){
                            PhoneAuthProvider.provider().verifyPhoneNumber("+91\(mobileNumber)", uiDelegate: nil) { verificationID, error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    loading.toggle()
                                }
                                self.verificationID = verificationID ?? ""
                                showProgress.toggle()
                                showVerify.toggle()
                                loading.toggle()
                            }
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(mobileNumber.trimmingCharacters(in: .whitespacesAndNewlines).count != 10 ? .gray : .blue)
                                .shadow(color: mobileNumber.trimmingCharacters(in: .whitespacesAndNewlines).count != 10 ? .gray : .blue, radius: 10)
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
                    .disabled(mobileNumber.trimmingCharacters(in: .whitespacesAndNewlines).count != 10 ? true : false)
                    NavigationLink(destination: OTPView(verificationID: verificationID, phoneNumber: mobileNumber)
                                                    .navigationBarHidden(true)
                                                    .navigationBarBackButtonHidden(true),
                                   isActive: $showVerify) {
                            Text("")
                        }
                        .hidden()
                    Spacer()
                    Text("Kevin's SportsTribe Assignment")
                        .foregroundColor(.gray)
                        .font(.custom("Lufga", size: 15))
                }
                .padding()
                ProgressView()
                    .opacity(showProgress ? 1.0 : 0.0)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

