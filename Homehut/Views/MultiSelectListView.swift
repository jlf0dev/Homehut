//
//  MultiSelectListView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/12/21.
//

import SwiftUI

struct MultiSelectListView<Item: Identifiable, Content: View>: View {
    @Binding var items: [Item]
    @Binding var selections: [Item]?
    
    var deleteAction: (IndexSet) -> Void
    var rowContent: (Item) -> Content
    

    
    func SelectionsContainsItem(_ selections: [Item]?, _ item: Item) -> Bool {
        if let selections = selections {
            return selections.contains(where: {$0.id == item.id })
        }
        else {
            return false
        }
    }

    var body: some View {
        List {
            ForEach(items) { item in
                rowContent(item)
                    .modifier(CheckmarkModifier(checked: selections?.contains(where: {$0.id == item.id}) ?? false))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if let sel = selections, sel.contains(where: {$0.id == item.id}) {
                            selections?.removeAll(where: {$0.id == item.id} )
                        }
                        else {
                            selections = (selections ?? []) + [item]
                        }
                }
            }
            .onDelete { deleteAction($0) }
        }
        
    }
}

struct CheckmarkModifier: ViewModifier {
    var checked: Bool = false
    func body(content: Content) -> some View {
        Group {
            if checked {
                ZStack(alignment: .trailing) {
                    content
                    Image("checkmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.green)
                        .shadow(radius: 1)
                }
            } else {
                content
            }
        }
    }
}



//struct SingleSelectListView_Previews: PreviewProvider {
//    static var mock = Array(0...10).map {
//    Location(name: "Item - \($0)")
//    
//    }
//    @State static var selectedItem: Location
//    
//    static var previews: some View {
//        VStack {
//                    Text("Selected Item: \(selectedItem.name)")
//                    Divider()
//            SingleSelectListView(items: mock, selectedItem: $selectedItem) { (item) in
//                        HStack {
//                            Text(item.name)
//                            Spacer()
//                        }
//                    }
//                }
//        
//    }
//}
