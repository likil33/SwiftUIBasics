

import SwiftUI


extension Notification.Name {
    static let testNotification = Notification.Name("testnotificaiton")
}


struct ContentView: View {
    
    @State private var getData:String?
    
    var body: some View {
        
        NavigationStack {
            VStack(){
                
                Button("PostNotification") {
                    NotificationCenter.default.post(name: Notification.Name.testNotification, object: "test data passing")
                }
                
                Text(getData ?? "")
                    .onReceive(NotificationCenter.default.publisher(for: Notification.Name.testNotification), perform: {
                        getData = $0.object as? String
                    })
               
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack (alignment: .leading)  {
                        HStack {
                            Image("profile")
                                .resizable()
                                .frame(maxWidth: 30 , maxHeight: 30)
                                .padding(.bottom, 5)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                            VStack (alignment: .leading) {
                                Text("Title")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(Font.custom("Helvetica Neue Medium", size: 18.0))
                                    .fontWeight(.regular)
                                
                                Text("sub title")
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                    .font(Font.custom("Helvetica Neue Medium", size: 14))
                                    .fontWeight(.regular)
                            }.padding()
                            
                            Spacer()
                            Image("notification")
                                .resizable()
                                .frame(maxWidth: 30 , maxHeight: 30)
                                .padding(.bottom, 5)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                        }
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.blue, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ContentView()
}

