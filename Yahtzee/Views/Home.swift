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
            Text("\(diceValue())")
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
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
    func diceValue() -> Int {
        if rolling {
            return 0
        }
        
        return -1
    }
}
struct Dice: Codable {
    var xRot : Float = .pi
    var yRot : Float = .pi
    var zRot : Float = .pi
    mutating func rollDice() {
        //Changes x y z random amount (.pi = 180 rotation)
        xRot += (.pi) * Float.random(in: 2.5...5.0)  * (Bool.random() ? -1.0 : 1.0)
        yRot += (.pi) * Float.random(in: 2.5...5.0)  * (Bool.random() ? -1.0 : 1.0)
        zRot += (.pi) * Float.random(in: 1.0...2.0)  * (Bool.random() ? -1.0 : 1.0)
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
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
