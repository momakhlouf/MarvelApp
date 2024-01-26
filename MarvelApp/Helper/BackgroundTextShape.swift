//
//  BackgroundTextShape.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI
struct ParallelogramShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path{ path in
            let horizontalOffset: CGFloat = rect.width * 0.08
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX , y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
    }
}

struct BackgroundTextShape: View {
    
    var body: some View {
        VStack{
            ParallelogramShape()
                .frame(width: 200 ,height: 45)
                .foregroundStyle(.white)
        }
        .padding()
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: 12, x: 0, y: 6)
       // .background(Color.red)
    }
}

#Preview {
    BackgroundTextShape()
}


