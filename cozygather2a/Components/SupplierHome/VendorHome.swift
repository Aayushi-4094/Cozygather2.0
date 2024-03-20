import SwiftUI
struct ToDoItemView: View {
    @Binding var task: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            if isEditing {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
                    .onTapGesture {
                        // Remove the task
                        task = ""
                    }
            }
            
            TextField("Enter task", text: $task)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
}


struct VendorMenuView: View {
    @Binding var isMenuExpanded: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Menu").font(.title)) {
                    NavigationLink(destination: Text("Payments")) {
                        Label("Payments", systemImage: "creditcard")
                    }
                    NavigationLink(destination: Text("Linked Accounts")) {
                        Label("Linked Accounts", systemImage: "link")
                    }
                }
                Section(header: Text("Settings").font(.title)) {
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Label("Privacy Policy", systemImage: "shield")
                    }
                    NavigationLink(destination: Text("Report")) {
                        Label("Report", systemImage: "flag")
                    }
                    NavigationLink(destination: Text("Settings")) {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Menu", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        withAnimation {
                            isMenuExpanded.toggle()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding()
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct VendorHomePage: View {
    @State private var isMenuExpanded = false
    @State private var isNotificationViewPresented = false
    @State private var tasks: [String] = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"]
    @State private var newTask: String = ""
    @State private var isEditing = false
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isMenuExpanded.toggle()
                                }
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .imageScale(.large)
                                    .padding(.leading, 16)
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            Text("Vendor Home Page")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                            Spacer()
                            NavigationLink(destination: Notification1()
                                                                    .navigationBarTitle("")
                                                                    .navigationBarHidden(true)
                                                    ) {
                                                        Image(systemName: "bell")
                                                            .imageScale(.large)
                                                            .padding(.trailing, 16)
                                                            .foregroundColor(.blue)
                                                    }
                        }
                        .navigationBarHidden(true)
                        .padding(.top, 10)
                        .background(Color(red: 247/255, green: 239/255, blue: 247/255))
                        Divider()
                        VStack {
                            HStack {
                                Text("No. of Orders Left")
                                    .font(.headline)
                                    .padding()
                                Divider()
                                Text("No. of Orders Completed")
                                    .font(.headline)
                                    .padding()
                            }
                            HStack {
                                Text("Value")
                                    .padding()
                                Divider()
                                Text("Value")
                                    .padding()
                            }
                            Divider()
                        }
                        
                        Divider()
                        
                        VStack {
                            HStack {
                                Text("To Do List")
                                    .font(.headline)
                                    .padding()
                                Spacer()
                                if !isEditing {
                                    Button(action: {
                                        isEditing.toggle()
                                    }) {
                                        Text("Edit")
                                            .foregroundColor(.blue)
                                    }
                                    .padding()
                                } else {
                                    Button(action: {
                                        isEditing.toggle()
                                    }) {
                                        Text("Done")
                                            .foregroundColor(.blue)
                                    }
                                    .padding()
                                }
                            }
                            ForEach(tasks.indices, id: \.self) { index in
                                ToDoItemView(task: $tasks[index], isEditing: $isEditing)
                            }
                            .onDelete(perform: deleteTask)
                            .onMove(perform: moveTask)
                            .padding(.bottom, 10)
                            
                            if isEditing {
                                Button(action: {
                                    if tasks.count < 10 {
                                        tasks.append("New Task")
                                    }
                                }) {
                                    Text("Add Task")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                            }
                        }
                    }
                    .navigationBarHidden(true)
                    .padding(.horizontal, 16)
                    .background(Color(red: 247/255, green: 239/255, blue: 247/255))
                }
                
                if isMenuExpanded {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isMenuExpanded.toggle()
                            }
                        }
                    
                    VendorMenuView(isMenuExpanded: $isMenuExpanded)
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut)
                        .background(Color(red: 247/255, green: 239/255, blue: 247/255))
                }
                
                VendorToolbar()
                    .frame(maxWidth: .infinity, alignment: .top)
                    .position(CGPoint(x: 200.0, y: 750.0))
                    
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use stack style for iPhone
        
    }
    
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    private func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
}




struct VendorHomePage_Previews: PreviewProvider {
    static var previews: some View {
        VendorHomePage()
    }
}
