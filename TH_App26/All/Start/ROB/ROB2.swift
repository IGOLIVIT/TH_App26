//
//  ROB2.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI

struct ROB2: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("r2")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 17) {
                    
                    Text("Track Your Tools")
                        .foregroundColor(.white)
                        .font(.system(size: 27, weight: .semibold))
                    
                    Text("Add, organize, and monitor the condition of your tools in one place.")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular))
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        ROB3()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(RoundedRectangle(cornerRadius: 7).fill(Color("bg")))
                    })
                    .padding(.bottom, 40)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 290)
                .background(Color.black)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ROB2()
}
