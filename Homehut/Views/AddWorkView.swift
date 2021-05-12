//
//  AddWorkView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import SwiftUI

struct AddWorkView: View {
    @State var titleText = ""
    @State var startDate = Date()
    @State var frequency = FrequencyType.oneTime
    @State var notes = ""

    
    var body: some View {
        ZStack{
            Color(UIColor.MyTheme.lightGrey1)
                .edgesIgnoringSafeArea(.all)
                
            ScrollView {
                VStack(alignment: .leading, spacing: 13){
                    BackBarView()
                    
                    Text("Add Work Item")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("BlackColor"))
                    
                    
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.title2)
                            .foregroundColor(Color("BlackColor"))
                        
                        TextField("What do you need to do?", text: $titleText)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    }
                    .padding(.vertical)
                    
                    
                    VStack {
                        HStack(alignment: .top, spacing: 20) {
                            VStack(alignment: .center){
                                Text("Date")
                                    .font(.title2)
                                    .foregroundColor(Color("BlackColor"))
                                
                                ZStack {
                                    Text(startDate, style: .date)
                                        .padding(8)
                                        .font(.body)
                                        .background(Color("BlackColor"))
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                    
                                    DatePicker("Date", selection: $startDate, displayedComponents: .date)
                                        .labelsHidden()
                                        .allowsHitTesting(true)
                                        .background(Color.clear)
                                        .accentColor(Color("BlackColor"))
                                        .opacity(0.1)

                                }
                                
                                
                                
                            }
                            Spacer()
                            VStack(alignment: .center, spacing: 16){
                                Text("Frequency")
                                    .font(.title2)
                                    .foregroundColor(Color("BlackColor"))
                                    
                                Picker(frequency.rawValue, selection: $frequency) {
                                        Text("One Time").tag(FrequencyType.oneTime)
                                        Text("Weekly").tag(FrequencyType.weekly)
                                        Text("Monthly").tag(FrequencyType.monthly)
                                        Text("Yearly").tag(FrequencyType.yearly)
                                    }.pickerStyle(MenuPickerStyle())
                                .foregroundColor(Color.white.opacity(0.85))
                                    .padding(9)
                                    .frame(width: 100, height: 34)
                                    .background(Color("BlackColor"))
                                    .cornerRadius(10)
                                    
                            }.padding(.trailing, 18)
                            
                        }.padding(.horizontal, 29)
                    }.padding(.vertical)
                    
                    
                    VStack(alignment: .leading){
                        Text("Location")
                            .font(.title2)
                            .foregroundColor(Color("BlackColor"))
                        HStack(){
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .frame(height: 34)
                                HStack {
                                    Text("Upstairs")
                                        .font(.body)
                                        .padding(.horizontal, 9)
                                    Spacer()
                                    Image("arrowRight")
                                        .resizable()
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15)
                                        .padding(.trailing, 2)
                                }
                            }
                        }
                    }.padding(.vertical)

                        
                    VStack(alignment: .leading){
                        Text("Notes")
                            .font(.title2)
                            .foregroundColor(Color("BlackColor"))
                        
                        
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $notes)
                                .frame(width: .infinity, height: 200)
                                .cornerRadius(10)
                            if notes == "" {
                                Text("Any further instructions or reminders?")
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .padding(7)
                                
                            }
                        }
                        
                    }.padding(.vertical)
                        



                }
            }
            .padding()
        }
    }
}


enum FrequencyType: String {
    case oneTime = "One Time"
    case weekly = "Weekly"
    case monthly = "Monthly"
    case yearly = "Yearly"

}


struct AddWorkView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkView()
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


