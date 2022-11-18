//
//  Home.swift
//  Yahtzee
//
//  Created by Alistair White on 11/15/22.
//

import SwiftUI
import SceneKit
import Model3DView

struct Home: View {
    //You have to initialize SCNScene up here instead of in DiceSceneView() for some reason or else it won't work
    @State private var scene: SCNScene? = .init(named: "Dice.usdz")
    @State private var rolling = false
    @State private var x : Float = .pi
    @State private var y : Float = .pi
    var body: some View {
        //Cool code
        VStack {
            DiceSceneView(scene: $scene)
                .frame(height: 200)
                .padding(.top, 50)
            Spacer()
            Button {
                //Stops user from spamming button
                rolling = true
                //Turns on animations
                SCNTransaction.animationDuration = 2.0
                
                //Changes x y z random amount (.pi = 180 rotation)
                x += (.pi) * Float.random(in: 2.0...4.0)  * (Bool.random() ? -1.0 : 1.0)
                y += (.pi) * Float.random(in: 2.0...4.0)  * (Bool.random() ? -1.0 : 1.0)
                //Sets the x y z rotation values to the random numbers
                scene?.rootNode.eulerAngles.x = x
                scene?.rootNode.eulerAngles.y = y
                
                //Delays by 0.1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                    //Rounds division to nearest whole number the re-multiplies to center it on a square
                    x = (round(x / (.pi / 2))) * (.pi / 2)
                    y = (round(y / (.pi / 2))) * (.pi / 2)
                    
                    //Sets recentered xy object rotation
                    scene?.rootNode.eulerAngles.x = x
                    scene?.rootNode.eulerAngles.y = y
                    rolling = false
                }
            } label: {
                Text("Spin")
            }
            .disabled(rolling)
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
