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
    @State var scene: SCNScene? = .init(named: "Dice.usdz")
    @State private var currX : Float = 0.0
    @State private var x : Float = 0.0
    @State private var y : Float = 0.0
    @State private var z : Float = 0.0
    //View Properties
    var body: some View {
        VStack {
            DiceSceneView(scene: $scene)
                .frame(height: 200)
                .padding(.top, 50)
            Spacer()
            Button {
                withAnimation (.linear(duration: 0.5)){
                    x += ((45 * .pi) / 360)
                    y += ((45 * .pi) / 360)
                    z += ((45 * .pi) / 360)
                    //y += 0.08
                    //z -= 0.07
                    //x = Float.random(in: 0...360)
                    //y = Float.random(in: 0...360)
                    //z = Float.random(in: 0...360)
                    //scene?.rootNode.eulerAngles.x = x
                    scene?.rootNode.eulerAngles.x = x
                    scene?.rootNode.eulerAngles.y = y
                    scene?.rootNode.eulerAngles.z = z
                    
                }
                
            } label: {
                Text("Spin")
            }
            
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
