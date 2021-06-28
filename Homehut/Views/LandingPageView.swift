//
//  LandingPageView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import SwiftUI

struct LandingPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var viewModel = LandingPageViewModel()
    
    @State private var text = ""
    
    @FetchRequest( entity: WorkItem.entity(),
                   sortDescriptors: [NSSortDescriptor(key: "titleValue", ascending: true)],
        animation: .default)
    
    private var workItems: FetchedResults<WorkItem>
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading)
            {
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading){
    
                        HouseImageView()
                            .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Welcome back Jake")
                                .font(.subheadline)
                            
                            Text("Organization is a journey, not a destination")
                                .font(.title)
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                            

                            
                        }.padding(.vertical)
                        
                        Text("Your reminders")
                            .font(.title2)
                        VStack {
                            TextField("Search", text: $text)
                                    .padding(8)
                                .padding(.horizontal, 25)
                                .background(RoundedRectangle(cornerRadius: 10)
                                                .fill(Color(UIColor.quaternarySystemFill)))
                                .overlay(
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 8)
                                 
//                                        if isEditing {
//                                            Button(action: {
//                                                self.text = ""
//                                            }) {
//                                                Image(systemName: "multiply.circle.fill")
//                                                    .foregroundColor(.gray)
//                                                    .padding(.trailing, 8)
//                                            }
//                                        }
                                    }
                                )
                        }.padding(.bottom)

                        ForEach (workItems) { workItem in
                            WorkCardView(workItem: workItem) // PREVIEW DATA
                        }
                    }
                    .padding()
                }
                .padding(.top, 1)
                
                    
                AppBarView()
                    .environment(\.managedObjectContext, self.viewContext)
                    .padding(.horizontal, 23)
                    .padding(.top, 10)
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
    

struct HouseImageView: View {
    var body: some View {
        HStack{
            VStack{
                Image("houseLandingPage")
                    .resizable()
//                    .renderingMode(.original)
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
        ForEach(ColorScheme.allCases, id: \.self) {
            LandingPageView().preferredColorScheme($0)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
