//
//  LandingPageView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import SwiftUI

struct LandingPageView: View {
    @ObservedObject private var viewModel = LandingPageViewModel()
    
    @State var text = ""
    
    @State private var moveToAddWorkView = false
    
    var body: some View {
        ZStack{
            Color(UIColor.MyTheme.lightGrey1)
                .edgesIgnoringSafeArea(.all)
                
            ScrollView {
                VStack(alignment: .leading){
                    AppBarView(beginNavigation: $moveToAddWorkView)
                        
                    HouseImageView()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Welcome back Jake")
                            .font(.subheadline)
                            .foregroundColor(Color("BlackColor"))
                        
                        Text("Organization is a journey, not a destination")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("BlackColor"))
                            .fixedSize(horizontal: false, vertical: true)
                        
                        ZStack {
                            TextField("Search for work", text: $text)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//                            if text.isEmpty {
//                                Text("Search for work")
//                                    .foregroundColor(Color("GrayColor"))
//                                    .padding(.horizontal)
//                                    .allowsHitTesting(false)
//
//                            }
                            
                        }
                        .padding(.vertical)
                        
                    }
                    
                    Text("Your work items")
                        .font(.title2)
                        .foregroundColor(Color("BlackColor"))

                    ForEach (viewModel.data) { workItem in
                        WorkCardView(workItem: workItem)
                    }
                }
            }
            .padding()
        }
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        .navigate(to: AddWorkView(), when: $moveToAddWorkView)
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
    
    
    
extension UIColor {
  struct MyTheme {
    static let lightGrey1 = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    static let lightGrey2 = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
    static let highlightColor = UIColor(red: 1.00, green: 0.47, blue: 0.33, alpha: 1.00)
    static let primaryColor3 = UIColor(red: 0.51, green: 0.51, blue: 0.60, alpha: 1.00)
    static let primaryColor2 = UIColor(red: 0.27, green: 0.26, blue: 0.38, alpha: 1.00)
    static let primaryColor1 = UIColor(red: 0.19, green: 0.15, blue: 0.32, alpha: 1.00)
  }
}
    
    
struct AppBarView: View {
    let frameSize: CGFloat? = 45
    
    @Binding var beginNavigation: Bool
    
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
            
            Button(action: {
                beginNavigation = true
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

struct WorkCardView: View {
    var workItem: WorkItemModel
    
    var body: some View {
        HStack(spacing: 13) {
            Image("cleaning")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding(7)
                .frame(width: 50)
                .background(Color("BlackColor"))
                .cornerRadius(10.0)
                .offset(x: -2)
                .fixedSize()
            
            VStack(alignment: .leading){
                if let loc = workItem.location {
                    Text(loc)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(Color("GrayColor"))
                }
                Text(workItem.title)
                    .lineLimit(1)
                    .font(.headline)
                    .foregroundColor(Color("BlackColor"))
                Text("Due " + workItem.startDateString)
                    .font(.footnote)
                    .foregroundColor(Color("BlackColor"))
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
    }
}
    
    
    
extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}

    
    
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
