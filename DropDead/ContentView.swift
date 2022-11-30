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
                Text("Drop Dead")
                    .font(.title).bold()
                NavigationLink("Player Select", destination: PlayerSelect(players: $players)
                    .navigationBarBackButtonHidden(true))
                NavigationLink("Test", destination: Home()
                    .navigationBarBackButtonHidden(true))
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
