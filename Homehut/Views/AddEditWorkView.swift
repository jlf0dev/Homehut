//
//  AddWorkView.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import SwiftUI
import CoreData

struct AddEditWorkView: View {
    @Environment(\.managedObjectContext) private var viewContext
    private var content: AnyView
    
    init(_ model: WorkItem? = nil ) {
        UITextView.appearance().backgroundColor = .clear
        
        if let model = model {
            self.content = AnyView(EditWorkView(workItem: model))
        } else {
            self.content = AnyView(AddWorkView())
        }
    }
    
    var body: some View {
        content
            .environment(\.managedObjectContext, self.viewContext)
    }
    
    private struct AddWorkView: View {
        @Environment(\.managedObjectContext) private var viewContext

        var body: some View {
            EditWorkView()
                .environment(\.managedObjectContext, self.viewContext)
        }
    }
    
    private struct EditWorkView: View {
        @Environment(\.presentationMode) var presentationMode
        @Environment(\.managedObjectContext) private var viewContext
        @Environment(\.colorScheme) var currentColorScheme
        
        
        var workItem: WorkItem? = nil
        private var addEditTitle: String
        private var originalImageArray: [UIImage]?
        
        @State private var showingLocationSheet = false
        @State private var title: String
        @State private var category: CategoryType
        @State private var dueDate: Date
        @State private var frequency: FrequencyType
        @State private var locations: Set<Location>?
        @State private var images: [UIImage]?
        @State private var notes: String
        @State private var showingImagePicker: Bool = false
        @State private var selectedImage: UIImage? = nil
        @State private var tappedImage: UIImage? = nil
        private var dismissConfirmation: Binding<Bool> { Binding (
            get: {
                if let wi = workItem {
                    if title == wi.title,
                       category == wi.category,
                       dueDate.toString() == wi.dueDate.toString(),
                       frequency == wi.frequency,
                       locations == wi.locations,
                       images == originalImageArray,
                       notes == wi.notes {
                        return false
                    }
                    else { return true }
                }
                else {
                    if title == "",
                       dueDate.toString() == Date().toString(),
                       frequency == .oneTime,
                       locations == nil,
                       images == nil,
                       notes == "" {
                        return false
                    }
                    else { return true }
                }
                
            },
            set: { _ in}
            )
        }

        
        init (workItem: WorkItem) {
            self.addEditTitle = "Edit"
            self.workItem = workItem
            originalImageArray = workItem.uiImageArray ?? [UIImage]()
            _title = State(initialValue: workItem.title)
            _category = State(initialValue: workItem.category)
            _dueDate = State(initialValue: workItem.dueDate)
            _frequency = State(initialValue: workItem.frequency)
            _locations = State(initialValue: workItem.locations)
            _images = State(initialValue: originalImageArray)
            _notes = State(initialValue: workItem.notes)
        }
        
        init () {
            self.addEditTitle = "Add"
            _title = State(initialValue: "")
            _category = State(initialValue: .general)
            _dueDate = State(initialValue: Date())
            _frequency = State(initialValue: .oneTime)
            _locations = State(initialValue: nil)
            _images = State(initialValue: nil)
            _notes = State(initialValue: "")
        }
        
        func saveWorkItem() {
            var newWorkItem: WorkItem
            
            if self.workItem != nil {
                newWorkItem = self.workItem!
            }
            else {
                newWorkItem = WorkItem(context: viewContext)
            }
            
            
            newWorkItem.title = self.title
            newWorkItem.category = self.category
            newWorkItem.dueDate = self.dueDate
            newWorkItem.frequency = self.frequency
            newWorkItem.locations = self.locations
            newWorkItem.notes = self.notes
            
            if let images = self.images {
                if let oldImages = newWorkItem.images {
                    for image in oldImages {
                        newWorkItem.removeFromImagesValue(image)
                    }
                }
                var order: Int16 = 1
                for image in images {
                    let newWorkImage = WorkImage(context: viewContext)
                    newWorkImage.image = image
                    newWorkImage.order = order
                    newWorkItem.addToImagesValue(newWorkImage)
                    order+=1
                }
            }
            
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }
        
        func loadNewImage() {
            guard let selectedImage = selectedImage else { return }
            if images == nil {
                images = [UIImage]()
            }
            
            if tappedImage != nil {
                let index = images!.firstIndex(where: { $0 == tappedImage })
                images![index!] = selectedImage
                    
            }
            else {
                images!.append(selectedImage)
            }
            
            
        }
        

        var body: some View {
            ZStack{
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                        
                    ScrollView {
                        ScrollViewReader { scroll in
                            ZStack{
                                Text("\(addEditTitle) Reminder")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                BackBarView(showDismissConfirmation: dismissConfirmation)
                            }
                            .padding(.horizontal, 23)
                            .padding(.top, 10)
                            
                            VStack(alignment: .leading, spacing: 13){
                                
        
                                TitleEntryView(title: $title)
                                    .padding(.vertical)
                                
                                
                                CategoryView(category: $category)
                                
                                
                                DateFrequencyView(dueDate: $dueDate, frequency: $frequency)
                                    .padding(.vertical)
                                
                                
                                LocationPickerView(showingLocationSheet: $showingLocationSheet, locations: $locations)
                                    .padding(.vertical)
                                    .sheet(isPresented: $showingLocationSheet) { LocationSelectionView(selectedLocations: $locations) }
                                
                                PicturePickerView(images: $images, showingImagePicker: $showingImagePicker, selectedImage: $selectedImage, tappedImage: $tappedImage)
                                    .padding(.vertical)
                                    .sheet(isPresented: $showingImagePicker, onDismiss: loadNewImage) { ImagePicker(image: $selectedImage) }
                                
                                NotesView(notes: $notes, scroll: scroll)
                                    .padding(.vertical)
                                
                                
                                VStack(alignment: .leading){
                                    Button(action: {
                                        saveWorkItem()
                                    }) {
                                        Text("Save")
                                            .fontWeight(.semibold)
                                            .font(.title)
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .contentShape(Rectangle())
                                    }
                                    .padding()
                                    .foregroundColor(currentColorScheme == .light ? .white : .black)
                                    .background(title == "" ? Color(.systemGray5) : Color(UIColor.label))
                                    .cornerRadius(40)
                                    .disabled(title == "")
                                    
                                }.padding(.vertical)
                            }.padding()
                        }
                    }.padding(.top, 1)
                }.navigationBarHidden(true)
                
            }
    }
}




struct TitleEntryView: View {
    @Binding var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.title2)
            TextField("What do you need to do?", text: $title)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
            
        }
    }
}

struct CategoryView: View {
    @Binding var category: CategoryType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Category")
                .font(.title2)
            HStack {
                ForEach (CategoryType.allCases, id:\.self) { currentCat in
                    VStack {
                        WorkCategoryIconView(category: currentCat)
                            .frame(width: 50)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                    .modifier(CheckmarkModifier(checked: category == currentCat ? true : false, alignment: .bottom))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        category = currentCat
                    }
                    
                }
            }
            .padding([.top, .horizontal])
        }
        .padding(.top)
    }
}

struct DateFrequencyView: View {
    @Binding var dueDate: Date
    @Binding var frequency: FrequencyType
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                Spacer()
                // Date
                VStack(alignment: .center){
                    Text("Date")
                        .font(.title2)
                    
                    ZStack {
                        Text(dueDate, style: .date)
                            .padding(8)
                            .font(.body)
                            .background(Color("blackColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                        
                        DatePicker("Date", selection: $dueDate, displayedComponents: .date)
                            .labelsHidden()
                            .allowsHitTesting(true)
                            .background(Color.clear)
                            .opacity(0.1)
                        
                    }
                }
                // Frequency
                Spacer()
                VStack(alignment: .center, spacing: 16){
                    Text("Frequency")
                        .font(.title2)
                    
                    Picker(frequency.rawValue, selection: $frequency) {
                        ForEach(FrequencyType.allCases) { freq in
                            Text(freq.rawValue)
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
        }
    }
}

struct LocationPickerView: View {
    @Binding var showingLocationSheet: Bool
    @Binding var locations: Set<Location>?
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Locations")
                .font(.title2)
            HStack(){
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.secondarySystemGroupedBackground))
                        .frame(height: 34)
                    HStack {
                        LocationTextView(showAll: true, showNone: true, locations: $locations)
                            .font(.body)
                            .padding(.horizontal, 9)
                            .lineLimit(1)
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                            .offset(x: -8)
                    }
                }.onTapGesture {
                    showingLocationSheet.toggle()
                }
            }
        }
    }
}

struct PicturePickerView: View {
    @Binding var images: [UIImage]?
    @Binding var showingImagePicker: Bool
    @Binding var selectedImage: UIImage?
    @Binding var tappedImage: UIImage?
    
    let imageFrameSize: CGFloat? = 75
    let placeholderFrameSize: CGFloat? = 75
    let xIconFrameSize: CGFloat? = 50
    
    
    
    struct imageRow: View {
        @Environment(\.colorScheme) var currentColorScheme
        
        @Binding var images: [UIImage]?
        @Binding var tappedImage: UIImage?
        @Binding var selectedImage: UIImage?
        @Binding var showingImagePicker: Bool
        
        let imageFrameSize: CGFloat?
        let placeholderFrameSize: CGFloat?
        let xIconFrameSize: CGFloat?
        
        let firstIndex: Int
        let lastIndex: Int
        
        
        
        var body: some View {
            HStack (alignment: .top) {
                if let imgs = images, !imgs.isEmpty {
                    ForEach(imgs.dropFirst(firstIndex).prefix(lastIndex), id: \.self) { img in
                        ZStack(alignment: .topLeading) {
                            Image(uiImage: img)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imageFrameSize)
                                .onTapGesture {
                                    tappedImage = img
                                    selectedImage = nil
                                    showingImagePicker = true
                                }
                            
                            Button(action: { images!.removeAll(where: {$0 == img}) }) {
                                Image(currentColorScheme == .light ? "xIconLight" : "xIconDark")
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: xIconFrameSize)
                                    .offset(x: -(xIconFrameSize! / 2), y: -(xIconFrameSize! / 2))
                                    .foregroundColor(Color(UIColor.label))
                            }
                        }
                        .padding()
                    }
                }
                if images == nil || images!.count < lastIndex {
                    Button(action: {
                        tappedImage = nil
                        selectedImage = nil
                        showingImagePicker = true
                    }) {
                    Image("imagePlaceholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: placeholderFrameSize)
                        .accentColor(Color(UIColor.label))
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pictures")
                .font(.title2)
            
            imageRow(images: self.$images, tappedImage: $tappedImage, selectedImage: $selectedImage, showingImagePicker: $showingImagePicker, imageFrameSize: imageFrameSize, placeholderFrameSize: placeholderFrameSize, xIconFrameSize: xIconFrameSize, firstIndex: 0, lastIndex: 3)
            if let imgs = images, imgs.count >= 3 {
                imageRow(images: self.$images, tappedImage: $tappedImage, selectedImage: $selectedImage, showingImagePicker: $showingImagePicker, imageFrameSize: imageFrameSize, placeholderFrameSize: placeholderFrameSize, xIconFrameSize: xIconFrameSize, firstIndex: 3, lastIndex: 6)
            }
            
        }
    }
}

struct NotesView: View {
    @Binding var notes: String
    var scroll: ScrollViewProxy
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Notes")
                .font(.title2)
            
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.quaternarySystemFill))
                    .frame(height: 120)
                
                if notes == "" {
                    Text("Any other notes or instructions?")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(7)
                }
                
                TextEditor(text: $notes)
                    .padding(.horizontal, 2)
                    .frame(height: 120)
                    .id(1)
                    
                
            }
            .onTapGesture {
                DispatchQueue.main.async {
                    withAnimation(.linear){
                        scroll.scrollTo(1, anchor: .center)
                    }
                }
            }
        }
    }
}


struct AddWorkView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AddEditWorkView().preferredColorScheme($0)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
