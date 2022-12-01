//
//  PlayerSelect.swift
//  DropDead
//
//  Created by Alistair White on 11/29/22.
//

import SwiftUI

struct PlayerSelect: View {
    @State private var rotationAmount = 0.0
    @Binding var players : [Player]
    @State private var showingAddPlayer = false
    //variable to be able to check the edit mode state
    @State var mode: EditMode = .inactive
    //used for custom back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            List {
                //prints out all players
                ForEach(0 ..< players.count, id: \.self) { i in
                    Text(players[i].name)
                }
                //delete players
                .onDelete { players.remove(atOffsets: $0) }
                .onMove { players.move(fromOffsets: $0, toOffset: $1) }
                //add new player button
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
                //edit button and custom back button
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
            //adding players when clicked add player button
            .sheet(isPresented: $showingAddPlayer) {
                AddPlayer(players: $players)
            }
            //assignes mode variable to the current state edit mode is in
            .environment(\.editMode, $mode)
        }
    }
}
struct AddPlayer : View {
    @Binding var players : [Player]
    @State var name : String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                //alows user to enter in their name
                TextField("Enter Name", text: $name)
            }
            .navigationTitle("Add New Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //confirm button
                ToolbarItem (placement: .navigationBarTrailing){
                    Button {
                        players.append(Player(name: self.name, point: 0))
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "checkmark.square")
                            .imageScale(.large)
                    }
                    //disalowes confirm if no player name entered
                    .disabled(name == "")
                }
                //back button
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
