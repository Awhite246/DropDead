//
//  Rules.swift
//  Yahtzee
//
//  Created by Alistair White on 11/27/22.
//

import SwiftUI

struct Rules: View {
    var body: some View {
        NavigationView {
            VStack {
                Header(text: "Gameplay")
                Text("The goal of drop dead is to score the highest amounts of points possible.")
                Header(text: "On your turn, roll 5 dice")
                Text("If the throw does not include a 2 or 5, they receive the score of the total numbers added together. That player is also able to roll the dice again. ")
                Header(text: "Rolling 2s or 5s")
                Text("When a player rolls the dice and any of them contain a 2 or 5, they score no points and the dice that includes a 2 or 5 is excluded from any future throws that they make.")
                Header(text: "Dropping Dead")
                Text("A player's turn does not stop until their last remaining die shows a 2 or 5. At that point, the player \"drops dead\" and it becomes the next player's turn")
                Header(text: "The highest total score wins.")
            }
        }
        .preferredColorScheme(.dark)
    }
}
struct Header: View {
    var text : String
    var body: some View {
        Text("\(text)")
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
    }
}
struct Rules_Previews: PreviewProvider {
    static var previews: some View {
        Rules()
    }
}
