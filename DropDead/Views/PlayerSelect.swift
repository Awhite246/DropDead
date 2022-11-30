//
//  PlayerSelect.swift
//  DropDead
//
//  Created by Alistair White on 11/29/22.
//

import SwiftUI

struct PlayerSelect: View {
    @State private var rotationAmount = 0.0
    @Binding var players : [String]
    @State private var showingAddPlayer = false
    //variable to be able to check the edit mode state
    @State var mode: EditMode = .inactive
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            List {
                ForEach(players, id: \.self) { player in
                        Text(player)
                        Spacer()
                }
                .onDelete { players.remove(atOffsets: $0) }
                .onMove { players.move(fromOffsets: $0, toOffset: $1) }
                Button {
                    showingAddPlayer = true
                } label: {
                    HStack {
                        Image(systemName: "plus.square")
                        Text("Add Player")
                    }
                }
                .disabled(mode.isEditing)
            }
            .preferredColorScheme(.dark)
            .navigationTitle("Player Select")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle")
                    }
                }
                ToolbarItem (placement: .navigationBarTrailing){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddPlayer) {
                AddPlayer(players: $players)
            }
            //assignes mode variable to the current state edit mode is in
            .environment(\.editMode, $mode)
        }
    }
}
struct AddPlayer : View {
    @Binding var players : [String]
    @State var name : String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Name", text: $name)
            }
            .navigationTitle("Add New Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing){
                    Button {
                        players.append(name)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "checkmark.square")
                            .imageScale(.large)
                    }
                    .disabled(name == "")
                }
                ToolbarItem (placement: .navigationBarLeading){
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.square")
                            .imageScale(.large)
                    }
                }
            }
        }
        .background(.black)
        .preferredColorScheme(.dark)
    }
}

struct PlayerSelect_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
