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
            ScrollView (.vertical){
                Group{
                    Text("Gameplay")
                        .font(.title2).bold()
                        .padding()
                    Text("The goal of Yahtzee is to obtain the highest score from throwing 5 dice. Players take turns to throw dice and score based on different dice combinations thrown.")
                    Header(text: "On your turn, roll the 5 dice")
                    Text("Roll dice. You can roll up to 3 times to form a scoring combination. On each roll, decide on which dice to set aside to score and which to re-roll.")
                    Header(text: "First Roll of Dice")
                    Text("Set aside any dice you wish to keep and continue rolling. You may also stop and score your current combination of dice.")
                    Header(text: "2nd Roll of Dice")
                    Text("Re-roll any dice or ALL of the dice (if you decided not to keep any in the first roll or changed your mind). After rolling, you may stop and score or set aside any dice you wish to keep and roll again.")
                    Header(text: "3rd Roll of Dice")
                    Text("Re-roll any dice or ALL of the dice. This is the final roll and you must now score by filling the boxes on your Yahtzee Score sheet.")
                }
                Group {
                    Text("Scoring")
                        .font(.title2).bold()
                        .padding()
                    Text("Score your 5 dice combination of 5 dice by filling the Yahtzee Score sheet. Yahtzee score sheet table has 2 sections, the Upper section and the Lower section. Once a box has been scored, it cannot be scored again for the remainder of the game (except the Yahtzee category) so choose wisely.")
                    Header(text: "3 of a Kind or 4 of a Kind")
                    Text("For 3 of a kind, you must have at least 3 of the same die faces and then you will score the total of all the dice. For 4 of a kind, you would need the same 4 dice faces.")
                    Header(text: "Full House")
                    Text("You have 3 of a kind and 2 of a kind. Full house’s score 25 points.")
                    Header(text: "Yahtzee")
                    Text("A Yahtzee is 5 of a kind and it scores 50 points. If you have scored 50 (not a zero) in the Yahtzee box, additional Yahtzees rolled give you bonus 100 points. Check the bonus box to tally your bonuses. You must also score the additional roll in any unscored Upper Section category. If the Upper Section category is scored, you can use the Yahtzee rolled as a JOKER and score any unscored Lower Section category.")
                    Header(text: "Chance")
                    Text("You can roll anything and be able to put it in the Chance category. You score the total of the die faces.")
                }
                Group {
                    Header(text: "Winning Yahtzee")
                    Text("After all 13 columns have been filled for each player the game ends. Each player totals there score and highest wins")
                }
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
