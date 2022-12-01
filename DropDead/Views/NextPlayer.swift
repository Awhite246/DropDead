//
//  NextPlayer.swift
//  DropDead
//
//  Created by Alistair White on 12/1/22.
//

import SwiftUI

struct NextPlayer: View {
    @State var name : String
    @State var point : Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("\(name)")
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                Text("Your Up!")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(.bottom, 35)
                Text("Last Player Got \(point) Point\(point > 1 ? "s" : "")")
                    .padding(50)
                Image(systemName: "checkmark.diamond")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
        .preferredColorScheme(.dark)
    }
}

struct NextPlayer_Previews: PreviewProvider {
    static var previews: some View {
        NextPlayer(name: "Player 1", point: 1)
    }
}
