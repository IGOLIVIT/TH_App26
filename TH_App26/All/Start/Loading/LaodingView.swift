//
//  LaodingView.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI

struct LaodingView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 80)
            }
        }
    }
}

#Preview {
    LaodingView()
}
