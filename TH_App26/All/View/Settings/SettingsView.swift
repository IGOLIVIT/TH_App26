//
//  SettingsView.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {

                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .medium))
                .padding()

                    ScrollView(.vertical, showsIndicators: false) {
                        
                        HStack {
                            
                            Button(action: {
                                
                                SKStoreReviewController.requestReview()
                                
                            }, label: {
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("Rate the app")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .regular))
                                        .frame(width: 80, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "star")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 22, weight: .regular))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 150)
                                .background(Color("bg"))
                            })
                            
                            Button(action: {
                                
                                guard let url = URL(string: "https://www.termsfeed.com/live/ee3ac46e-1e2a-48aa-a198-b5d9b18dfae9") else { return }
                                
                                UIApplication.shared.open(url)
                                
                            }, label: {
                                
                                VStack(alignment: .leading) {

                                    Text("Usage policy")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .regular))
                                        .frame(width: 80, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "menucard")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 22, weight: .regular))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 150)
                                .background(Color("bg"))
                            })
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
            }
        }
    }
}

#Preview {
    SettingsView()
}
