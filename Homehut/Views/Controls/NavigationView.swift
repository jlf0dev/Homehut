//
//  NavigationView.swift
//  Homehut
//
//  Created by Jacob Fink on 6/27/21.
//

import SwiftUI

struct AppBarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let frameSize: CGFloat? = 45
    
    @State var navigateToAddWorkView = false
    
    var body: some View {
        HStack{
            
            Button(action: {}) {
                Image("profile")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: frameSize)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
            
            Spacer()
            
            NavigationLink(destination: AddEditWorkView().environment(\.managedObjectContext, self.viewContext), isActive: $navigateToAddWorkView) {
                Button(action: {
                    navigateToAddWorkView = true
                }) {
                    Image("addIcon")
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
}

struct BackBarView: View {
    let frameSize: CGFloat? = 45
    @Binding var showDismissConfirmation: Bool
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        HStack{
            Button(action:
                    {
                        if showDismissConfirmation {
                            showingAlert = true
                        }
                        else {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
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
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Leave without saving?"),
                message: Text("You will lose all changes"),
                primaryButton: .destructive(Text("Leave")) {
                    self.presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
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

