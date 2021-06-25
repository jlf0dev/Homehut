//
//  WorkCardView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/17/21.
//

import SwiftUI

struct WorkCardView: View {
    @ObservedObject var workItem: WorkItem
    @State private var navigateToWorkItemView = false

    
    var body: some View {
        NavigationLink(destination: WorkItemView(workItem: workItem), isActive: $navigateToWorkItemView) {
            HStack(spacing: 13) {
                
                WorkCategoryIconView(category: workItem.category)
                VStack(alignment: .leading){
                    LocationTextView(locations: $workItem.locations)
                            .font(.caption.weight(.medium))
                            .foregroundColor(Color("grayColor"))
                    
                    Text(workItem.title)
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(Color("blackColor"))
                    Group {
                        Text("Due ")
                        + Text(workItem.dueDate, style: .date)
                    }
                    .font(.footnote)
                    .foregroundColor(Color("blackColor"))
                    
                }
                Spacer()
                
                Image("arrowRight")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15)
                    .offset(x: 6)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(18.0)
            .onTapGesture {
                navigateToWorkItemView = true
            }
        }
    }
}


struct WorkCategoryIconView: View {
    var category: CategoryType

    var body: some View {
        Image(category.label)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .padding(7)
            .frame(width: 50)
            .background(category.backgroundColor)
            .cornerRadius(10.0)
            .offset(x: -2)
            .fixedSize()
    }
}




struct WorkCardView_Previews: PreviewProvider {
    static var workItem = WorkItem(context: PersistenceController.preview.container.viewContext)
    static var loc = Location(context: PersistenceController.preview.container.viewContext)

    static var previews: some View {
        WorkCardView(workItem: workItem)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .onAppear(){
                workItem.title = "Clean the bathroom"
                workItem.dueDate = Date()
                workItem.category = CategoryType.clean
                workItem.frequency = FrequencyType.oneTime
                loc.name = "Bathroom"
                workItem.locations?.insert(loc)
            }
    }
}
