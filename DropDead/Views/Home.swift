//
//  Home.swift
//  Yahtzee
//
//  Created by Alistair White on 11/15/22.
//

import SwiftUI
import SceneKit

struct Home: View {
    //Dices
    @State private var diceScene1: SCNScene? = .init(named: "Dice.usdz") //You have to initialize SCNScene up here instead of in DiceSceneView() for some reason or else it won't work
    @StateObject private var dice1 = Dice()
    @State private var diceScene2: SCNScene? = .init(named: "Dice.usdz")
    @StateObject private var dice2 = Dice()
    @State private var diceScene3: SCNScene? = .init(named: "Dice.usdz")
    @StateObject private var dice3 = Dice()
    @State private var diceScene4: SCNScene? = .init(named: "Dice.usdz")
    @StateObject private var dice4 = Dice()
    @State private var diceScene5: SCNScene? = .init(named: "Dice.usdz")
    @StateObject private var dice5 = Dice()
    
    //Stops button presses if dice is currently rolling
    @State private var rolling = false
    @State private var point = 0
    //wether or not to show rule or point view
    @State private var showingRule = false
    @State private var showingPoint = false
    @State private var nextPlayer = false
    //stores player names and point values
    @State var players : [String]
    @State private var points : [Int] = []
    //index of current player
    @State private var currentPlayer = 0
    var body: some View {
        let diceSize : CGFloat = 100
        let activateColor : Color = .white
        let deactivateColor : Color = .red
        //Cool code
        VStack {
            //all the dice
            HStack {
                DiceSceneView(scene: $diceScene4)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice4.isActivated() ? activateColor : deactivateColor)
                DiceSceneView(scene: $diceScene5)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice5.isActivated() ? activateColor : deactivateColor)
            }
            .padding(.top, 50)
            HStack {
                DiceSceneView(scene: $diceScene1)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice1.isActivated() ? activateColor : deactivateColor)
                DiceSceneView(scene: $diceScene2)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice2.isActivated() ? activateColor : deactivateColor)
                DiceSceneView(scene: $diceScene3)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice3.isActivated() ? activateColor : deactivateColor)
            }
            
            .padding(50)
            //displayers current player info
            Text("Current Player: \(players[currentPlayer])")
                .font(.title3).bold()
            Text("Points : \(point)")
                .font(.title).bold()
            Spacer()
            .disabled(rolling)
            
            //Rolls the dice
            Button("Roll Dice") {
                if !rolling {
                    //Stops user from spamming button
                    rolling = true
                    
                    //Changes x y z random amount (.pi = 180 rotation)
                    rollDice()
                    //Sets the x y z rotation values to the random numbers
                    updateDice(animationTime: 2.0)
                    //Delays by 2.0 seconds, so centering of dice appears as seperate animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        
                        //Rounds division to nearest whole number the re-multiplies to center it on a square
                        centerDice()
                        //Sets recentered xy object rotation
                        updateDice(animationTime: 0.5)
                        
                        updatePoints()
                        rolling = false
                        //checks if no dice left
                        if droppedDead() {
                            //moves to next player
                            points[currentPlayer] += point
                            currentPlayer += 1
                            currentPlayer %= players.count
                            point = 0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                //bit of delay so user doesnt get confused
                                nextPlayer = true
                                resetDice()
                                updateDice(animationTime: 0.0)
                            }
                        }
                    }
                }
            }
            .font(.title2).bold()
            .disabled(rolling || droppedDead())
        }
        //fixes crash problem where points.count != players.count
        .onAppear {
            resetDice()
            for _ in players {
                points.append(0)
            }
        }
        //shows other views when variable is switched
        .sheet(isPresented: $showingRule, content: {
            Rules()
        })
        .sheet(isPresented: $showingPoint, content: {
            Points(players: players, points: points)
        })
        .fullScreenCover(isPresented: $nextPlayer, content: {
            NextPlayer(name: players[currentPlayer], point: points[currentPlayer == 0 ? players.count - 1 : currentPlayer - 1]) //makes sure point != -1
        })
        .navigationTitle("Drop Dead")
        .toolbar{
            //show point view button
            ToolbarItem (placement: .navigationBarLeading) {
                Button {
                    showingPoint = true
                } label: {
                    Image(systemName:"plusminus.circle")
                }
            }
            //help / show rules button
            ToolbarItem (placement: .navigationBarTrailing) {
                Button {
                    showingRule = true
                } label: {
                    Image(systemName: "questionmark.circle")
                }
                
            }
            
        }
    }
    //reset dice to starting values
    func resetDice() {
        dice1.resetDice()
        dice2.resetDice()
        dice3.resetDice()
        dice4.resetDice()
        dice5.resetDice()
        point = 0
        dice1.setActivation(true)
        dice2.setActivation(true)
        dice3.setActivation(true)
        dice4.setActivation(true)
        dice5.setActivation(true)
    }
    func rollDice() {
        dice1.rollDice()
        dice2.rollDice()
        dice3.rollDice()
        dice4.rollDice()
        dice5.rollDice()
    }
    func centerDice() {
        dice1.centerDice()
        dice2.centerDice()
        dice3.centerDice()
        dice4.centerDice()
        dice5.centerDice()
    }
    //checks if all dice are deativated
    func droppedDead() -> Bool{
        if dice1.isActivated() {
            return false
        }
        if dice2.isActivated() {
            return false
        }
        if dice3.isActivated() {
            return false
        }
        if dice4.isActivated() {
            return false
        }
        if dice5.isActivated() {
            return false
        }
        return true
    }
    //updates point values
    func updatePoints() {
        var dropDead = false
        //checks if should be deactivated then updates activated value
        if dice1.isActivated() && (dice1.getValue() == 2 || dice1.getValue() == 5) {
            dropDead = true
            dice1.setActivation(false)
        }
        if dice2.isActivated() && (dice2.getValue() == 2 || dice2.getValue() == 5) {
            dropDead = true
            dice2.setActivation(false)
        }
        if dice3.isActivated() && (dice3.getValue() == 2 || dice3.getValue() == 5) {
            dropDead = true
            dice3.setActivation(false)
        }
        if dice4.isActivated() && (dice4.getValue() == 2 || dice4.getValue() == 5) {
            dropDead = true
            dice4.setActivation(false)
        }
        if dice5.isActivated() && (dice5.getValue() == 2 || dice5.getValue() == 5) {
            dropDead = true
            dice5.setActivation(false)
        }
        //skips point updating if any dice got deactivated this round
        if dropDead { return }
        //update points from activated dice
        if dice1.isActivated() {
            point += dice1.getValue()
        }
        if dice2.isActivated() {
            point += dice2.getValue()
        }
        if dice3.isActivated() {
            point += dice3.getValue()
        }
        if dice4.isActivated() {
            point += dice4.getValue()
        }
        if dice5.isActivated() {
            point += dice5.getValue()
        }
    }
    //updates dice position
    func updateDice(animationTime : Double) {
        //animation duration
        SCNTransaction.animationDuration = animationTime
        diceScene1?.rootNode.eulerAngles = dice1.getVector()
        diceScene2?.rootNode.eulerAngles = dice2.getVector()
        diceScene3?.rootNode.eulerAngles = dice3.getVector()
        diceScene4?.rootNode.eulerAngles = dice4.getVector()
        diceScene5?.rootNode.eulerAngles = dice5.getVector()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(players: ["Player 1", "Player 2"])
    }
}
