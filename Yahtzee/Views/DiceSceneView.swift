//
//  DiceSceneView.swift
//  Yahtzee
//
//  Created by Alistair White on 11/17/22.
//

import SwiftUI
import SceneKit

struct DiceSceneView: UIViewRepresentable {
    @Binding var scene: SCNScene?
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.antialiasingMode = .multisampling2X
        view.autoenablesDefaultLighting = true
        view.scene = scene
        view.backgroundColor = .clear
        view.preferredFramesPerSecond = UIScreen.main.maximumFramesPerSecond
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
}

struct DiceSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
