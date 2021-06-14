//
//  LandingPageView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import SwiftUI

struct LandingPageView: View {
    @StateObject private var viewModel = LandingPageViewModel()
    
    @State private var text = ""
    
    
    var body: some View {
        NavigationView {
            ZStack
            {
                Color("backgroundColor")
                    .edgesIgnoringSafeArea(.all)
                    
                ScrollView {
                    VStack(alignment: .leading){
                        AppBarView()
                            
                        HouseImageView()
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Welcome back Jake")
                                .font(.subheadline)
                                .foregroundColor(Color("blackColor"))
                            
                            Text("Organization is a journey, not a destination")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("blackColor"))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            VStack {
                                TextField("Search for work", text: $text)
                                        .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            }.padding(.vertical)
                            
                        }
                        
                        Text("Your work items")
                            .font(.title2)
                            .foregroundColor(Color("blackColor"))

                        ForEach (previewData) { workItem in
                            WorkCardView(workItem: workItem) // PREVIEW DATA
                        }
                    }
                }
                .padding()
            }
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            .navigationBarHidden(true)
        }
    }
}

    
extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}
    
    
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
    
    
struct AppBarView: View {
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
            
            NavigationLink(destination: AddEditWorkView(), isActive: $navigateToAddWorkView) {
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

struct HouseImageView: View {
    var body: some View {
        HStack{
            VStack{
                Image("houseLandingPage")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .padding()
                
                
                Ellipse()
                    .fill(Color.black)
                    .blur(radius: 8)
                    .frame(width: 140, height: 2)
                    .padding()
            }
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}

    
    
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
