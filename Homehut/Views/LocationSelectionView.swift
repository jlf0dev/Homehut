//
//  LocationSelectionView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/14/21.
//

import SwiftUI

struct LocationSelectionView: View {
    @Binding var selectedLocations: Set<Location>?
    
    @State var editMode: EditMode = .inactive
    
    @FetchRequest( entity: Location.entity(),
                   sortDescriptors: [NSSortDescriptor(key: "nameValue", ascending: true)],
        animation: .default)
    private var locationList: FetchedResults<Location>
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(UIColor.MyTheme.lightGrey1)
                    .edgesIgnoringSafeArea(.all)
                List {
                    ForEach(locationList) { location in
                        HStack {
                            Text(location.name)
                            Spacer()
                        }
                            .modifier(CheckmarkModifier(checked: selectedLocations?.contains(location) ?? false))
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if let sel = selectedLocations, sel.contains(location) {
                                    selectedLocations?.remove(location)
                                }
                                else {
                                    if selectedLocations == nil {
                                        selectedLocations = Set<Location>()
                                    }
                                    selectedLocations?.insert(location)
                                }
                        }
                    }
                    .onDelete (perform: deleteItem)
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

struct CheckmarkModifier: ViewModifier {
    var checked: Bool = false
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            Image("checkmark")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.green)
                .shadow(radius: 1)
                .opacity(checked ? 1 : 0)
                .animation(nil)
        }
    }
}

struct LocationTextView: View {
    var showAll = false
    var showNone = false
    @Binding var locations: Set<Location>?
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
//    @FetchRequest(
//        entity: Location.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Location.name, ascending: true),
//        ],
//        predicate: NSPredicate(format: "name == %@", "Bathroom")
//    ) static var bathroom: FetchedResults<Location>
    
//    static var bath: Location = Location(context: PersistenceController.preview.container.viewContext)
//
//    static var upstairs: Location = Location(context: PersistenceController.preview.container.viewContext)
//
//    static var downstairs: Location = Location(context: PersistenceController.preview.container.viewContext)
//
//    static var bedroom: Location = Location(context: PersistenceController.preview.container.viewContext)
//
    
    @State static var locationPreviewSet: Set<Location>?

    static var previews: some View {
        LocationSelectionView(selectedLocations: $locationPreviewSet)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//            .onAppear(){
//                bedroom.name = "Bedroom"
//                downstairs.name = "Downstairs"
//                upstairs.name = "Upstairs"
//                bath.name = "Bathroom"
////                for bath in bathroom {
////                locationPreviewSet?.insert(bathroom.first!)
////                }
//            }
    }
}
