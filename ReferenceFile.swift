/*
 ================
 MARK: - 1. intial start file
================
 start
 
 import SwiftUI

 @main
 struct SwiftUITestApp: App {
     var body: some Scene {
         WindowGroup {
             ContentView()
         }
     }
 }
 
 
 ================
 MARK: - 2. List Dispaly - Add item , Delete item, Move item, Separator Hidden,
 
 .contentShape(Rectangle()) -  complete row clickble inside
 ================
 
 struct ContentView:View {
     
     @State private var friendName:String = ""
     @State private var friends:[String] = ["santhosh","Kumar"]
     
     
     private func deleteTask(indexSet:IndexSet) {
         indexSet.forEach { index in
             friends.remove(at: index)
         }
     }
     
     var body: some View {
         NavigationView {
             VStack {
                 HStack {
                     TextField("Enter Name", text: $friendName)
                         .textFieldStyle(.roundedBorder)
                     Button("Add") {
                         friends.append(friendName)
                         friendName = ""
                     }
                 }
                 List {
                     ForEach(friends, id: \.self) { friend in
                         HStack {
                             Text(friend)
                             Spacer()
                         }.listRowSeparator(.hidden)
                          .contentShape(Rectangle())
                         
                     }.onDelete(perform: deleteTask)
                         .onMove(perform: { indices, newOffset in
                             friends.move(fromOffsets: indices, toOffset: newOffset)
                         })
                 }.listStyle(.plain)
                     .toolbar {
                         EditButton()
                     }
             }.padding()
         }
     }
 }
 
 
 
 ================
 MARK: - 3. Section Header and List display
 ================
 
 import SwiftUI

 struct Post:Identifiable {
     let id = UUID()
     let title:String
     var comments:[Comment]
 }
 struct Comment : Identifiable {
     let id = UUID()
     let title:String
 }

 struct ContentView : View {
     
     init() {
         UITableView.appearance().backgroundColor = UIColor.red
     }
     
     let posts = [Post(title: "Post #1", comments: [Comment(title: "comment1"),Comment(title: "comment2")]),
                  Post(title: "Post #2", comments: [Comment(title: "comment1"),Comment(title: "comment2")]),
                  Post(title: "Post #3", comments: [Comment(title: "comment1"),Comment(title: "comment2")])]
     
     var body: some View {
         NavigationView {
             List {
                 ForEach(posts) { post in
                     Section(header: Text(post.title)) {
                         ForEach(post.comments) { comment in
                             HStack {
                                 Text(comment.title)
                                 Spacer()
                             }.listRowBackground(Color.green)
                         }
                     }
                 }
             }
         }
     }
 }

 
 
 
 ================
 MARK: - 4. ScrollView - Dispaly list of data and background color change
 ================
 
 struct ContentView:View {
     var body: some View {
         ScrollView {
             LazyVStack {
                 ForEach(1...10, id: \.self) { count in
                     HStack {
                         VStack(alignment:.leading){
                             Text("\(count)")
                             Divider()
                         }
                         Spacer()
                     }
                 }
             }
             .padding()
             .background(Color.green)
         }
         .background(Color.gray)
     }
 }
 
 
 
 
 
 ================
 MARK: - 5. Pull to Refresh : List and delete option
 ================
 
 struct ContentView:View {
     @State private var refreshableDate:[Date] = [Date()]
     
     private func onDeletedate(indexSet:IndexSet) {
         indexSet.forEach { index in
             refreshableDate.remove(at: index)
         }
     }
     
     var body: some View {
         NavigationView {
             List {
                 ForEach(refreshableDate, id:\.self) { date in
                     Text("\(date)")
                 }
                 .onDelete(perform: onDeletedate)
             }
             .listStyle(.plain)
             .refreshable {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                     let dateTime = Date()
                     refreshableDate.append(dateTime)
                 }
             }
         }
         .navigationTitle("Pull to refresh Date list")
     }
 }
 
 
 
 
 
 
 ================
 MARK: - 5. Search : List
 ================
 import SwiftUI


 struct Place:Identifiable {
     let id = UUID()
     let name:String
     let photo:String
 }

 func getPlacesList() -> [Place] {
     return [
            Place(name: "Add", photo: "add"),
            Place(name: "Camera", photo: "camera"),
            Place(name: "Search Gray", photo: "searchgray"),
            Place(name: "Search White", photo: "searchWhite"),
            Place(name: "typeC Port", photo: "typeCPorts"),
            Place(name: "USB Port", photo: "usbPorts")
     ]
 }

 struct ContentView:View {
     
     @State private var places = getPlacesList()
     @State private var search = String()
     
     var body: some View {
         NavigationView {
             List(places) { place in
                 HStack(alignment: .top ) {
                     Image(place.photo)
                         .resizable()
                         .frame(maxWidth: 50, maxHeight: 50)
                         .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                     Text(place.name)
                         .font(.title)
                 }
             }.listStyle(.plain)
                 .searchable(text: $search)
                 .onChange(of: search, perform: { newValue in
     if !newValue.isEmpty && newValue.count >= 1 {
                         places = places.filter {
                             $0.name.lowercased().hasPrefix(newValue.lowercased())
                         }
                     }
                     else {
                         places = getPlacesList()
                     }
                 })
             
                 .navigationTitle("Places")
         }
     }
 }


 #Preview {
     ContentView()
 }

 
 ================
 MARK: - 6. Sample Login Form : Screen design
 ================
 
 import SwiftUI


 struct ContentView:View {
     
     @State var name:String  = ""
     @State var password:String  = ""
     @State var showPassword:Bool = false
     
     var isSignInButtonDisabled:Bool {
         [name, password].contains(where: \.isEmpty)
     }
     
     var body: some View {
         VStack(alignment: .leading, spacing: 15) {
             Spacer()
             TextField("Name", text: $name, prompt: Text("Please enter name").foregroundColor(.blue))
                 .padding(10)
                 .overlay {
                     RoundedRectangle(cornerRadius: 10)
                         .stroke(.gray, lineWidth: 2)
                 }
                 .padding(.horizontal)
                     
             HStack {
                 Group {
                     if showPassword {
                         TextField("Password", text: $password, prompt: Text("Please enter Password").foregroundColor(.blue))
                     }
                     else {
                         SecureField("Password", text: $password, prompt: Text("Please enter Password").foregroundColor(.blue))
                     }
                 }
                 .padding(10)
                 .overlay {
                     RoundedRectangle(cornerRadius: 10)
                         .stroke(.gray, lineWidth: 2)
                 }
                 
                 Button {
                     showPassword.toggle()
                 } label: {
                     Image(systemName: showPassword ? "eye.slash" : "eye")
                         .foregroundColor(.red)
                 }
             }.padding(.horizontal)
             Spacer()
             
             Button {
                 print("Login")
             } label: {
                 Text("Sign In")
                     .font(.title2)
                     .bold()
                     .foregroundColor(.white)
             }
             .frame(height: 50)
             .frame(maxWidth: .infinity)
             .background(
                 isSignInButtonDisabled ?
                 LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomLeading) :
                 LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomLeading))
             .cornerRadius(20)
             .disabled(isSignInButtonDisabled)
             .padding()
         }
     }
 }

 #Preview {
     ContentView()
 }

 
 
 */
