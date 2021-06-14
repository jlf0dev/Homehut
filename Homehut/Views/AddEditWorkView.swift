//
//  AddWorkView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import SwiftUI

struct AddEditWorkView: View {
    
    private var content: AnyView
    
    init(_ model: Binding<WorkItemModel>? = nil ) {
        UITextView.appearance().backgroundColor = .clear
        if let model = model {
            self.content = AnyView(EditWorkView(workItem: model))
        } else {
            self.content = AnyView(AddWorkView())
        }
    }
    
    var body: some View {
        content
    }
    
    private struct AddWorkView: View {
        @State private var workItem = WorkItemModel()
        
        var body: some View {
            EditWorkView (workItem: $workItem)
        }
    }
    
    private struct EditWorkView: View {
        @ObservedObject private var viewModel = AddWorkViewModel()
        @Binding var workItem: WorkItemModel
        
        @State private var showingLocationSheet = false

        var body: some View {
            ZStack{
                Color(UIColor.MyTheme.lightGrey1)
                    .edgesIgnoringSafeArea(.all)
                        
                    ScrollView {
                        VStack(alignment: .leading, spacing: 13){
                            ZStack{
                                Text("Add Work Item")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("blackColor"))
                                
                                BackBarView()
                                
                            }
                            
                            
                            VStack(alignment: .leading) {
                                Text("Title")
                                    .font(.title2)
                                    .foregroundColor(Color("blackColor"))
                                
                                TextField("What do you need to do?", text: $workItem.title)
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            }
                            .padding(.vertical)
                            
                            
                            VStack {
                                HStack(alignment: .top, spacing: 20) {
                                    Spacer()
                                    VStack(alignment: .center){
                                        Text("Date")
                                            .font(.title2)
                                            .foregroundColor(Color("blackColor"))
                                        
                                        ZStack {
                                            Text(workItem.dueDate, style: .date)
                                                .padding(8)
                                                .font(.body)
                                                .background(Color("blackColor"))
                                                .foregroundColor(Color.white)
                                                .cornerRadius(10)
                                            
                                            DatePicker("Date", selection: $workItem.dueDate, displayedComponents: .date)
                                                .labelsHidden()
                                                .allowsHitTesting(true)
                                                .background(Color.clear)
                                                .accentColor(Color("blackColor"))
                                                .opacity(0.1)

                                        }
                                        
                                        
                                        
                                    }
                                    Spacer()
                                    VStack(alignment: .center, spacing: 16){
                                        Text("Frequency")
                                            .font(.title2)
                                            .foregroundColor(Color("blackColor"))
                                            
                                        Picker(workItem.frequency.rawValue, selection: $workItem.frequency) {
                                            ForEach(FrequencyType.allCases) { frequency in
                                                Text(frequency.rawValue)
                                                }
                                            }
                                            .pickerStyle(MenuPickerStyle())
                                            .foregroundColor(Color.white.opacity(0.9))
                                            .padding(9)
                                            .frame(width: 100, height: 35)
                                            .background(Color("blackColor"))
                                            .cornerRadius(10)
                                            .offset(y: -1)
                                            
                                    }
                                    Spacer()
                                    
                                }
                            }.padding(.vertical)
                            
                            
                            VStack(alignment: .leading){
                                Text("Location")
                                    .font(.title2)
                                    .foregroundColor(Color("blackColor"))
                                HStack(){
                                    
                                    
//                                    Button{
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white)
                                                .frame(height: 34)
                                            HStack {
                                                LocationTextView(showAll: true, showNone: true, locations: $workItem.location)
                                                    .font(.body)
                                                    .padding(.horizontal, 9)
                                                    .lineLimit(1)
                                                
                                                Spacer()
                                                Image("arrowRight")
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 15)
                                                    .padding(.trailing, 2)
                                            }
                                        }.onTapGesture {
                                            showingLocationSheet.toggle()
                                        }
//                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }.padding(.vertical)

                                
                            VStack(alignment: .leading){
                                Text("Notes")
                                    .font(.title2)
                                    .foregroundColor(Color("blackColor"))
                                
                                
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(height: 120)
                                    
                                    if workItem.notes.isEmptyOrNil{
                                        Text("Any other notes or instructions?")
                                            .foregroundColor(Color(UIColor.placeholderText))
                                            .padding(7)
                                    }
                                    
                                    TextEditor(text: $workItem.notes ?? "")
                                        .padding(.horizontal, 2)
                                        .frame(height: 120)

                                }
                                
                            }.padding(.vertical)

                        }
                    }.padding()
                }.navigationBarHidden(true)
                .sheet(isPresented: $showingLocationSheet) {
                    LocationSelectionView(selectedLocations: $workItem.location)
                }
            }
        }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

extension Optional where Wrapped: Collection {
  var isEmptyOrNil: Bool {
    guard let value = self else { return true }
    return value.isEmpty
  }
}


struct AddWorkView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddEditWorkView()
        }
    }
}

struct BackBarView: View {
    let frameSize: CGFloat? = 45
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack{
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Image("backArrowLeft")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(7)
                    .frame(width: frameSize)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
            Spacer()
        }
    }
}


struct BackOptionsBarView: View {
    let frameSize: CGFloat? = 45
    @Environment(\.presentationMode) var presentationMode
    @Binding var showOptions: Bool
    
    var body: some View {
        HStack{
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Image("backArrowLeft")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(7)
                    .frame(width: frameSize)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
            Spacer()
            
            Button(action: { showOptions = true }) {
                Image("options")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                    .frame(width: frameSize)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
        }
    }
}
