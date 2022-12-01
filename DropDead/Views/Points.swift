//
//  Points.swift
//  DropDead
//
//  Created by Alistair White on 12/1/22.
//

import SwiftUI

struct Points: View {
    @State var players : [String]
    @State var points : [Int]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            List {
                //shows a list of all players and point values next to them
                ForEach(players, id: \.self) { player in
                    HStack {
                        Text(player)
                        Spacer()
                        Text("\(points[players.firstIndex(of: player) ?? 0])")
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
        Points(players: ["test","poop","pow"], points: [1,2,3])
    }
}
