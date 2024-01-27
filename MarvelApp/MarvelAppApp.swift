//
//  MarvelAppApp.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI

@main
struct MarvelAppApp: App {
    @State private var showLaunchView: Bool = true
    var body: some Scene {
        WindowGroup {
            ZStack{
                CharacterView(viewModel: DependencyProvider.characterViewModel)
               
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
             //   .zIndex(2)
            }
        }
    }
}
