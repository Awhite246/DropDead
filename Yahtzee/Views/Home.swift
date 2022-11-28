//
//  Home.swift
//  Yahtzee
//
//  Created by Alistair White on 11/15/22.
//

import SwiftUI
import SceneKit

struct Home: View {
    //You have to initialize SCNScene up here instead of in DiceSceneView() for some reason or else it won't work
    @State private var diceScene1: SCNScene? = .init(named: "Dice.usdz")
    @State private var dice1 = Dice()
    @State private var diceScene2: SCNScene? = .init(named: "Dice.usdz")
    @State private var dice2 = Dice()
    @State private var diceScene3: SCNScene? = .init(named: "Dice.usdz")
    @State private var dice3 = Dice()
    @State private var diceScene4: SCNScene? = .init(named: "Dice.usdz")
    @State private var dice4 = Dice()
    @State private var diceScene5: SCNScene? = .init(named: "Dice.usdz")
    @State private var dice5 = Dice()
    @State private var diceScene6: SCNScene? = .init(named: "Dice.usdz")
    @State private var dice6 = Dice()
    @State private var rolling = false
    var body: some View {
        //Cool code
        VStack {
            HStack {
                DiceSceneView(scene: $diceScene1)
                    .frame(width: 50, height: 50)
                    .padding(.top, 50)
                DiceSceneView(scene: $diceScene2)
                    .frame(width: 50, height: 50)
                    .padding(.top, 50)
                DiceSceneView(scene: $diceScene3)
                    .frame(width: 50, height: 50)
                    .padding(.top, 50)
                DiceSceneView(scene: $diceScene4)
                    .frame(width: 50, height: 50)
                    .padding(.top, 50)
                DiceSceneView(scene: $diceScene5)
                    .frame(width: 50, height: 50)
                    .padding(.top, 50)
                DiceSceneView(scene: $diceScene6)
                    .frame(width: 50, height: 50)
                    .padding(.top, 50)
            }
            Spacer()
            Text("\(dice1.getValue())")
                .font(.title).bold()
            Button("Roll Dice"){
                if !rolling {
                    //Stops user from spamming button
                    rolling = true
                    //Turns on animations
                    SCNTransaction.animationDuration = 2.0
                    
                    //Changes x y z random amount (.pi = 180 rotation)
                    dice1.rollDice()
                    dice2.rollDice()
                    dice3.rollDice()
                    dice4.rollDice()
                    dice5.rollDice()
                    dice6.rollDice()
                    //Sets the x y z rotation values to the random numbers
                    diceScene1?.rootNode.eulerAngles = dice1.getVector()
                    diceScene2?.rootNode.eulerAngles = dice2.getVector()
                    diceScene3?.rootNode.eulerAngles = dice3.getVector()
                    diceScene4?.rootNode.eulerAngles = dice4.getVector()
                    diceScene5?.rootNode.eulerAngles = dice5.getVector()
                    diceScene6?.rootNode.eulerAngles = dice6.getVector()
                    //Delays by 0.1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        SCNTransaction.animationDuration = 0.75
                        
                        //Rounds division to nearest whole number the re-multiplies to center it on a square
                        dice1.centerDice()
                        dice2.centerDice()
                        dice3.centerDice()
                        dice4.centerDice()
                        dice5.centerDice()
                        dice6.centerDice()
                        //Sets recentered xy object rotation
                        diceScene1?.rootNode.eulerAngles = dice1.getVector()
                        diceScene2?.rootNode.eulerAngles = dice2.getVector()
                        diceScene3?.rootNode.eulerAngles = dice3.getVector()
                        diceScene4?.rootNode.eulerAngles = dice4.getVector()
                        diceScene5?.rootNode.eulerAngles = dice5.getVector()
                        diceScene6?.rootNode.eulerAngles = dice6.getVector()
                        rolling = false
                    }
                }
            }
        }
    }
}
struct Dice: Codable {
    var xRot : Float = 0
    var yRot : Float = 0
    var zRot : Float = 0
    mutating func rollDice() {
        //Changes x y z random amount (.pi = 180 rotation)
        xRot += (.pi) * Float.random(in: 3.1...4.9)  * (Bool.random() ? -1.0 : 1.0)
        yRot += (.pi) * Float.random(in: 3.1...4.9)  * (Bool.random() ? -1.0 : 1.0)
        zRot += (.pi) * Float.random(in: 1.0...3.0)  * (Bool.random() ? -1.0 : 1.0)
    }
    mutating func centerDice() {
        //Rounds division to nearest whole number the re-multiplies to center it on a square
        xRot = (round(xRot / (.pi / 2))) * (.pi / 2)
        yRot = (round(yRot / (.pi / 2))) * (.pi / 2)
        zRot = (round(zRot / (.pi))) * (.pi)
    }
    func getVector() -> SCNVector3 {
        return SCNVector3(x: xRot, y: yRot, z: zRot)
    }
    //gets the value of the dice facing the user
    func getValue() -> String {
        var str = "Num: "
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
            str += "1"
        case 01:
            str += "5"
        case 02:
            str += "6"
        case 03:
            str += "2"
        case 10:
            str += "4"
        case 11:
            str += "5"
        case 12:
            str += "3"
        case 13:
            str += "2"
        case 20:
            str += "6"
        case 21:
            str += "5"
        case 22:
            str += "1"
        case 23:
            str += "2"
        case 30:
            str += "3"
        case 31:
            str += "5"
        case 32:
            str += "4"
        case 33:
            str += "2"
        default:
            str += "-1"
        }
        str += "\n x: \(xTemp), y: \(yTemp)"
        return str
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
