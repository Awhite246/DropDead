//
//  DiceSceneView.swift
//  Yahtzee
//
//  Created by Alistair White on 11/17/22.
//

import SwiftUI
import SceneKit

//Video Used For Help: https://www.youtube.com/watch?v=d4ciSOLvIH8&t=236s
//3D Object Credits: "Dice" (https://skfb.ly/Ftpp) by dez_z is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).

struct DiceSceneView: UIViewRepresentable {
    @Binding var scene: SCNScene?
    
    func makeUIView(context: Context) -> SCNView {
        //Creating all the properties
        let view = SCNView()
        view.allowsCameraControl = false
        view.antialiasingMode = .multisampling2X
        view.autoenablesDefaultLighting = true
        view.scene = scene
        view.backgroundColor = .clear
        view.preferredFramesPerSecond = UIScreen.main.maximumFramesPerSecond
        return view
    }
    
    //Dont realy know why u need this but you do
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
}

struct DiceSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
