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
    @State private var rolling = false
    @State private var dice1 = Dice()
    var body: some View {
        //Cool code
        VStack {
            DiceSceneView(scene: $diceScene1)
                .frame(height: 200)
                .padding(.top, 50)
            Spacer()
            Text("\(dice1.getValue())")
        }
        .onTapGesture {
            if !rolling {
                //Stops user from spamming button
                rolling = true
                //Turns on animations
                SCNTransaction.animationDuration = 2.0
                
                //Changes x y z random amount (.pi = 180 rotation)
                dice1.rollDice()
                //Sets the x y z rotation values to the random numbers
                diceScene1?.rootNode.eulerAngles = dice1.getVector()
                //Delays by 0.1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    SCNTransaction.animationDuration = 0.75
                    
                    //Rounds division to nearest whole number the re-multiplies to center it on a square
                    dice1.centerDice()
                    
                    //Sets recentered xy object rotation
                    diceScene1?.rootNode.eulerAngles = dice1.getVector()
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.75) {
                    SCNTransaction.animationDuration = 0.0
                    dice1.resetDice()
                    rolling = false
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
        xRot += (.pi) * Float.random(in: 4.5...6.5)  * (Bool.random() ? -1.0 : 1.0)
        yRot += (.pi) * Float.random(in: 4.5...6.5)  * (Bool.random() ? -1.0 : 1.0)
        zRot += (.pi) * Float.random(in: 1.0...2.0)  * (Bool.random() ? -1.0 : 1.0)
    }
    mutating func centerDice() {
        //Rounds division to nearest whole number the re-multiplies to center it on a square
        xRot = (round(xRot / (.pi / 2))) * (.pi / 2)
        yRot = (round(yRot / (.pi / 2))) * (.pi / 2)
        zRot = (round(zRot / (.pi))) * (.pi)
    }
    mutating func resetDice() {
        xRot = Float((Int((round(xRot / (.pi / 2)))) % 4)) * (.pi / 2)
        yRot = Float((Int((round(yRot / (.pi / 2)))) % 4)) * (.pi / 2)
    }
    //Rolls dice in directions
    mutating func rollDown() {
        xRot += .pi / 2
    }
    mutating func rollRight() {
        yRot += .pi / 2
    }
    func getVector() -> SCNVector3 {
        return SCNVector3(x: xRot, y: yRot, z: zRot)
    }
    func getValue() -> Int {
        //Rounds float down into 4 rotation amounts
        let xTemp = Int(round(xRot / (.pi / 2))) % 4
        let yTemp = Int(round(yRot / (.pi / 2))) % 4
        let value = xTemp * 10 + yTemp
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
