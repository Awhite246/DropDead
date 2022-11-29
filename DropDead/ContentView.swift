//
//  ContentView.swift
//  Yahtzee
//
//  Created by Alistair White on 10/31/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Home()
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
