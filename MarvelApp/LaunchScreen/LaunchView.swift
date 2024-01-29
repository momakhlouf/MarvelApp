//
//  LaunchView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct LaunchView: View {
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @Binding var showLaunchView: Bool
    @State var width: CGFloat = 1
    var body: some View {
        ZStack{
            Color(Color.theme.launchBackground)
                .ignoresSafeArea()
            
            Image("launchLogo")
                .resizable()
                .frame(width: 250, height: 250)
                .foregroundStyle(.white)
            
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 150 , height: 5)
                        .foregroundStyle(.gray.opacity(0.6))
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: width , height: 5)
                        .foregroundStyle(.white)
                    
                }
                .offset(y: 70)

        }
        .onReceive(timer, perform: { _ in
            withAnimation {
                if width < 150{
                    width += 8
                }else{
                    showLaunchView = false
                }
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
