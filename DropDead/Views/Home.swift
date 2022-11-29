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
    //Keeps track of number of times dice has appeared
    @State private var count = [0,0,0,0,0,0]
    @State private var point = 0
    var body: some View {
        let diceSize : CGFloat = 100
        let deactivateColor : Color = .red
        //Cool code
        VStack {
            HStack {
                DiceSceneView(scene: $diceScene4)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice4.isActivated() ? .white : deactivateColor)
                DiceSceneView(scene: $diceScene5)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice5.isActivated() ? .white : deactivateColor)
            }
            .padding(.top, 50)
            HStack {
                DiceSceneView(scene: $diceScene1)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice1.isActivated() ? .white : deactivateColor)
                DiceSceneView(scene: $diceScene2)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice2.isActivated() ? .white : deactivateColor)
                DiceSceneView(scene: $diceScene3)
                    .frame(width: diceSize, height: diceSize)
                    .colorMultiply(dice3.isActivated() ? .white : deactivateColor)
            }
            .padding()
            Text("Points : \(point)")
                .font(.title).bold()
            Spacer()
            Button("Reset Dice") {
                resetDice()
                updateDice(animationTime: 0.0)
            }
            .disabled(rolling)
            //Displays all count values
            ForEach(0..<6, id: \.self) { num in
                Text("Count \(num + 1): \(count[num])")
            }
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
                        checkActivation()
                        rolling = false
                        //For debugging (I think random value arent random enough)
                        count[dice1.getValue() - 1] += 1
                        count[dice2.getValue() - 1] += 1
                        count[dice3.getValue() - 1] += 1
                        count[dice4.getValue() - 1] += 1
                        count[dice5.getValue() - 1] += 1
                    }
                }
            }
            .disabled(rolling)
        }
    }
    func resetDice() {
        dice1.resetDice()
        dice2.resetDice()
        dice3.resetDice()
        dice4.resetDice()
        dice5.resetDice()
        point = 0
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
    func updatePoints() {
        if dice1.isActivated() { point += dice1.getValue() }
        if dice2.isActivated() { point += dice2.getValue() }
        if dice3.isActivated() { point += dice3.getValue() }
        if dice4.isActivated() { point += dice4.getValue() }
        if dice5.isActivated() { point += dice5.getValue() }
    }
    //updates dice position
    func updateDice(animationTime : Double) {
        SCNTransaction.animationDuration = animationTime
        diceScene1?.rootNode.eulerAngles = dice1.getVector()
        diceScene2?.rootNode.eulerAngles = dice2.getVector()
        diceScene3?.rootNode.eulerAngles = dice3.getVector()
        diceScene4?.rootNode.eulerAngles = dice4.getVector()
        diceScene5?.rootNode.eulerAngles = dice5.getVector()
    }
    //checks if rolled 2 or 5
    func checkActivation() {
        dice1.dropDead()
        dice2.dropDead()
        dice3.dropDead()
        dice4.dropDead()
        dice5.dropDead()
    }
}
class Dice : ObservableObject {
    //xyz value of dice
    private var xRot : Float = 0
    private var yRot : Float = 0
    private var zRot : Float = 0
    //dice activation value
    private var activated : Bool = true
    func resetDice() {
        xRot = 0
        yRot = 0
        zRot = 0
        activated = true
    }
    func rollDice(reroll : Bool = false) {
        if !activated { return }
        let xRandom = (.pi / 2) * (4 + Float.random(in: 0...4))  * (Bool.random() ? -1.0 : 1.0)
        let yRandom = (.pi / 2) * (4 + Float.random(in: 0...4))  * (Bool.random() ? -1.0 : 1.0)
        //Changes x y z random amount (.pi = 180 rotation)
        xRot += xRandom
        yRot += yRandom
        //fixes randomness
        if ((Bool.random() || reroll) && (getValue() == 2 || getValue() == 5)){
            xRot -= xRandom
            yRot -= yRandom
            rollDice(reroll: true)
        }
        zRot += (.pi) * Float.random(in: 1.0...3.0)  * (Bool.random() ? -1.0 : 1.0)
    }
    func centerDice() {
        //Rounds division to nearest whole number the re-multiplies to center it on a square
        xRot = (round(xRot / (.pi / 2))) * (.pi / 2)
        yRot = (round(yRot / (.pi / 2))) * (.pi / 2)
        zRot = (round(zRot / (.pi))) * (.pi)
    }
    func dropDead(){
        if getValue() == 2 || getValue() == 5 {
            setActivation(false)
        } else {
            setActivation(true)
        }
    }
    func setActivation(_ activate : Bool) {
        activated = activate
    }
    func toggle() {
        activated.toggle()
    }
    func getVector() -> SCNVector3 {
        return SCNVector3(x: xRot, y: yRot, z: zRot)
    }
    //returns wether or not dice is being used
    func isActivated() -> Bool {
        return activated
    }
    //gets the value of the dice facing the user
    func getValue() -> Int {
        //Rounds float down into 4 rotation amounts
        var xTemp = Int(round(xRot / (.pi / 2))) % 4
        var yTemp = Int(round(yRot / (.pi / 2))) % 4
        //corrects negative numbers
        if (xTemp < 0){
            xTemp += 4
        }
        if (yTemp < 0){
            yTemp += 4
        }
        let value = xTemp * 10 + yTemp
        //dont know a smarter way of doing this so just hardcoding values
        switch value {
        case 00:
            return 1
        case 01:
            return 5
        case 02:
            return 6
        case 03:
            return 2
        case 10:
            return 4
        case 11:
            return 5
        case 12:
            return 3
        case 13:
            return 2
        case 20:
            return 6
        case 21:
            return 5
        case 22:
            return 1
        case 23:
            return 2
        case 30:
            return 3
        case 31:
            return 5
        case 32:
            return 4
        case 33:
            return 2
        default:
            return -1
        }
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
