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
        xRot += (.pi) * Float.random(in: 3.0...5.0)  * (Bool.random() ? -1.0 : 1.0)
        yRot += (.pi) * Float.random(in: 3.0...5.0)  * (Bool.random() ? -1.0 : 1.0)
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
        str += ", x: \(xTemp), y: \(yTemp)"
        return str
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
