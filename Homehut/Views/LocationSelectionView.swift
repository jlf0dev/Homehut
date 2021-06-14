//
//  LocationSelectionView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/14/21.
//

import SwiftUI

struct LocationSelectionView: View {
    @Binding var selectedLocations: [Location]?
    
    @State var locationList: [Location] = previewLocationData
    @State var editMode: EditMode = .inactive
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(UIColor.MyTheme.lightGrey1)
                    .edgesIgnoringSafeArea(.all)
                MultiSelectListView(items: $locationList, selections: $selectedLocations, deleteAction: deleteItem) { (item) in
                    HStack {
                        Text(item.name)
                        Spacer()
                    }
                }
            }.navigationTitle("Locations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    public func deleteItem(offsets: IndexSet) {
        print("item deleted")
    }
    
    public func addItem() {
        
    }
}

struct LocationTextView: View {
    var showAll = false
    var showNone = false
    @Binding var locations: [Location]?
    var body: Text {
        if let locs = locations, !locs.isEmpty {
            if (locs.count == 1){
                return Text(locs.first!.name)
            }
            else {
                if showAll {
                    return Text(locs.reduce("") { $0 == "" ? $1.name : $0 + ", " + $1.name })
                }
                else {
                    return Text(locs.first!.name + " & more")
                }
            }
        }
        else {
            if showNone {
                return Text("None")
            }
            else {
                return Text("")
            }
        }
    }
}


struct LocationSelectionView_Previews: PreviewProvider {
    @State static var locationData: [Location]? = [
        Location("Kitchen"),
        Location("Bathroom")]
    static var previews: some View {
        LocationSelectionView(selectedLocations: $locationData)
    }
}
