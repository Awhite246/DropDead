//
//  Points.swift
//  DropDead
//
//  Created by Alistair White on 12/1/22.
//

import SwiftUI

struct Points: View {
    @State var players : [Player]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            List {
                //shows a list of all players and point values next to them
                ForEach(0 ..< players.count , id: \.self) { i in
                    HStack {
                        Text(players[i].name)
                        Spacer()
                        Text("\(players[i].point)")
                    }
                }
            }
            .navigationTitle("Points")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar {
                //custom back button (navigation back button ugly)
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle")
                    }
                }
            }
        }
    }
}

struct Points_Previews: PreviewProvider {
    static var previews: some View {
        Points(players: [Player(name: "fred", point: 1)])
    }
}
