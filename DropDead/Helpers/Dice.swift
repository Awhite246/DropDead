//
//  Dice.swift
//  DropDead
//
//  Created by Alistair White on 12/1/22.
//

import Foundation

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
        //fixes randomness (kind of janky but idk how to do it a different way other than completly changing the random generator from ground up)
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
