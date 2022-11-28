//
//  Start.swift
//  Yahtzee
//
//  Created by Alistair White on 11/28/22.
//

import SwiftUI

struct Start: View {
    var body: some View {
        VStack{
            ZStack {
                Image("DiceLogo")
                    .resizable()
                    .frame(width:300, height: 150)
                Color(.black)
                    .frame(width:125, height: 50)
                    .opacity(0.3)
                Text("Yahtzee")
                    .font(.title).bold()
            }
            .padding(.bottom, 100)
            Button {
                
            } label: {
                Text("Start Game")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
            Button {
                
            } label: {
                Text("Players")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
