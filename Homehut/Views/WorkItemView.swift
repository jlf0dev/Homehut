//
//  WorkItemView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/16/21.
//

import SwiftUI

struct WorkItemView: View {
    @ObservedObject var workItem: WorkItem
    
    @State var showOptions: Bool = false
    @State var navigationSelection: String? = nil
    
    var body: some View {
        ZStack
        {
            Color(UIColor.MyTheme.lightGrey1)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .center, spacing: 13){
                    ZStack{
                        Text("Work Item")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("blackColor"))
                        
                        BackOptionsBarView(showOptions: $showOptions)
                    }
                        
                    HStack() {
                        WorkCategoryIconView(category: workItem.category)
                            .frame(width: 50)
                    
                        Text(workItem.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("blackColor"))
                            .multilineTextAlignment(.center)
                    }

                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Due")
                            .font(.subheadline)
                            .foregroundColor(Color("blackColor"))
                    
                        Text(workItem.dueDate, style: .date)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("blackColor"))
                            .multilineTextAlignment(.center)
                    }
                    
                    
                }
            }.padding()
            .actionSheet(isPresented: $showOptions) {
                    ActionSheet(title: Text("Options"),
                                buttons: [
                                    .cancel(),
                                    .default(
                                        Text("Edit"),
                                        action: { navigationSelection = "edit" }
                                    ),
                                    .destructive(
                                        Text("Delete"),
                                        action: { }
                                    )
                                    
                                ]
                    )
                }
            
            NavigationLink(destination: AddEditWorkView(workItem), tag: "edit", selection: $navigationSelection) { EmptyView() }
        }.navigationBarHidden(true)
    }
}

struct WorkItemView_Previews: PreviewProvider {
    static var workItem = WorkItem(context: PersistenceController.preview.container.viewContext)
    static var loc = Location(context: PersistenceController.preview.container.viewContext)
    static var previews: some View {
        WorkItemView(workItem: workItem)
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
