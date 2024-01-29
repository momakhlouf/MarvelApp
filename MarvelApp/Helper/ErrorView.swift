//
//  ErrorView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 27/01/2024.
//

import SwiftUI

struct ErrorView: View {
    let error : String
    var refresh : () -> ()
    var body: some View {
        // we can use ContentUnavailableView but only in iOS 17.
        VStack{
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundStyle(.gray)
                .font(.system(size: 100, weight: .heavy))
            
            Text(error)
                .foregroundStyle(.gray)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding(.vertical, 5)
            Button(action: {
                refresh()
            }, label: {
                Text("Refresh")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                    .frame(width: 200 , height: 50)
                    .background(Color.theme.customRed.cornerRadius(12))
                    .padding()
            })
        }
    }
}

#Preview {
    ErrorView(error: "", refresh: {})
}
