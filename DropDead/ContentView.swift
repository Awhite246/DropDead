//
//  ContentView.swift
//  Yahtzee
//
//  Created by Alistair White on 10/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var players : [String] = []
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("DiceLogo")
                        .resizable()
                        .frame(width: 300, height: 150)
                    Color.black
                        .frame(width:175, height: 50)
                        .opacity(0.5)
                    Text("Drop Dead")
                        .font(.title).bold()
                }
                .padding(.bottom, 100)
                NavigationLink("Player Select", destination: PlayerSelect(players: $players)
                    .navigationBarBackButtonHidden(true))
                .font(.title2).bold()
                .padding(25)
                NavigationLink("Rules", destination: Rules()
                    .navigationBarBackButtonHidden(true))
                .font(.title2).bold()
                .padding(25)
                NavigationLink("Test", destination: Home()
                    .navigationBarBackButtonHidden(true))
                .font(.title2).bold()
                .padding(25)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
