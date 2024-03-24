import SwiftUI
import FirebaseAuth

struct EventData: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: EventData, rhs: EventData) -> Bool {
        return lhs.id == rhs.id
    }
}

struct EventCard: View {
    @State private var isDetailViewPresented = false
    var event: EventData

    var randomBackgroundColor: Color {
        let colors: [Color] = [Color(red: 247/225, green: 239/255, blue: 247/255)]
           // .background(Color(red: 247/225, green: 239/255, blue: 247/255))
        return colors.randomElement() ?? .gray
    }

    var body: some View {
        ZStack {
            randomBackgroundColor
                .cornerRadius(12)
            HStack {
                VStack {
                    Image(event.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 250, height: 180)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    Text(event.name)
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                        .padding(.bottom, 2)
                        .padding(.top, 1)

                    Button(action: {
                        isDetailViewPresented.toggle()
                    }) {
                        Text("View Details")
                            .foregroundColor(.black)
                            .padding(.top, 0)
                            .padding(.bottom, 2)
                            .cornerRadius(8)
                            .font(.system(size: 12))
                    }
                    .sheet(isPresented: $isDetailViewPresented) {
                        EventDetailView(event: event)
                    }
                }
                .padding(.horizontal, 30)
                .frame(width: 150)
            }
            .padding(10)
        }
    }
}

struct EventDetailView: View {
    var event: EventData
    @State private var isTaskLinkActive = false

    var body: some View {
        VStack {
            Text("Event Details")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text(event.name)
                .font(.headline)
                .padding(.bottom, 8)

            Image(event.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(12)
                .padding(8)
                .shadow(radius: 5)

            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color.gray.opacity(1))
                    .frame(height: 50)
                    .overlay(
                        Text("Days : Hours : Minutes")
                            .foregroundColor(.black)
                            .padding(.horizontal)
                    )
                    .padding(.horizontal, 40)
                    .offset(y: -240)

                VStack {
                    Text("Co-Host")
                        .font(.headline)
                        .padding(.bottom, 8)
                    Text("Date and time")
                        .font(.headline)
                        .padding(.bottom, 8)
                    Text("Location")
                        .font(.headline)
                        .padding(.bottom, 8)
                    Text("Description")
                        .font(.headline)
                        .padding(.bottom, 8)
                    Text("Vendor assigned")
                        .font(.headline)
                        .padding(.bottom, 8)

                    Button(action: {
                        isTaskLinkActive = true
                    }) {
                        Text("Task")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.bottom, 8)
                    }
                    .sheet(isPresented: $isTaskLinkActive) {
                        // Replace "TaskView" with the view you want to navigate to for the task
                        TaskView()
                    }
                }
            }

            Spacer()
        }
        .navigationBarTitle("Event Detail", displayMode: .inline)
        .background(Color(red: 247/225, green: 239/255, blue: 247/255))
    }
}

struct SeeAllView: View {
    var eventData: [EventData]

    var body: some View {
        NavigationView {
            GridView(eventData: eventData)
                .navigationBarTitle("See All", displayMode: .inline)
        }
        .padding(.all, -20)
        //.background(Color(red: 198/225, green: 174/255, blue: 128/255))
    }
}

struct GridView: View {
    var eventData: [EventData]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 0) {
                ForEach(eventData, id: \.self) { event in
                    EventCard(event: event)
                        .padding(100)
                        .frame(width: 250, height: 250)
                }
                .padding(20)
            }
            .padding(20)
        }
        //.background(Color(red: 198/225, green: 174/255, blue: 128/255))
    }
}

struct MenuView: View {
    @Binding var isMenuExpanded: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Menu").font(.title)) {
                    NavigationLink(destination: UserProfile()) {
                        Label("Profile", systemImage: "person.circle")
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                    NavigationLink(destination: Notification1()) {
                        Label("Notification", systemImage: "bell")
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                    NavigationLink(destination: Text("Payments")) {
                        Label("Payments", systemImage: "creditcard")
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                    NavigationLink(destination: Text("Linked Accounts")) {
                        Label("Linked Accounts", systemImage: "link")
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                }
                Section(header: Text("Settings").font(.title)) {
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Label("Privacy Policy", systemImage: "shield")
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                    NavigationLink(destination: Text("Report")) {
                        Label("Report", systemImage: "flag")
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                    NavigationLink(destination: Text("Settings")) {
                        Label("Settings", systemImage: "gearshape")
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                }
            }
            //.background(Color(red: 247/225, green: 239/255, blue: 247/255))
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Menu", displayMode: .inline)
            .foregroundColor(.black)
            .navigationBarItems(
                trailing: Button(action: {
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
        ////.background(Color(red: 240/225, green: 240/255, blue: 234/255))
       // .background(Color(red: 247/225, green: 239/255, blue: 247/255))
    }
}

struct UserHomeView: View {
    @State private var isSeeAllPresented = false
    @State private var isMenuExpanded = false
    @State private var isAddEventPresented = false
    

    let myEventsData = [
        EventData(name: "Birthday Bash", imageName: "event1"),
        EventData(name: "Summer Fiesta", imageName: "event2"),
        EventData(name: "Joyful Gathering", imageName: "event3")
    ]

    let upcomingEventsData = [
        EventData(name: "Beach Party", imageName: "event4"),
        EventData(name: "Dance Night", imageName: "event5"),
        EventData(name: "Sunset Soiree", imageName: "event6")
    ]
    var username: String // Username passed from sign-up process
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                isMenuExpanded.toggle()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .imageScale(.large)
                                .padding(.leading, 40)
                                .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                        }
                        .foregroundColor(.primary)
                    }
                    .padding(.bottom, 40)

                    Text("Hi \(username)!!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, -40)
                        .padding(.top, 40)
                        .foregroundColor(Color(red: 67/225, green: 13/255, blue: 75/255))

                    Spacer()

                    VStack {
                        NavigationLink(destination: CreateEvent(selectedCoHosts: .constant([]))) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .padding(.trailing, 16)
                                .padding(.bottom, 40)
                                .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                        }
                        .navigationTitle("home")
                        .navigationBarTitle("", displayMode: .inline)
                        .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .padding(.top, 20)
                Divider()

                HStack {
                    Text("My Events")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    Spacer()

                    Button(action: {
                        isSeeAllPresented.toggle()
                    }) {
                        Text("See All")
                            .padding(.trailing, 16)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                    }
                    .sheet(isPresented: $isSeeAllPresented) {
                        SeeAllView(eventData: myEventsData)
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(myEventsData, id: \.self) { event in
                            EventCard(event: event)
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.trailing, 10)

                Divider()
                HStack {
                    Text("Upcoming Events")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                        .padding(.horizontal, 20)
                        .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))

                    Spacer()

                    Button(action: {
                        isSeeAllPresented.toggle()
                    }) {
                        Text("See All")
                            .font(.title2)
                            .padding(.trailing, 16)
                            .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
                    }
                    .sheet(isPresented: $isSeeAllPresented) {
                        SeeAllView(eventData: upcomingEventsData)
                            //.background(Color(red: 250/225, green: 244/255, blue: 250/255))
                            .background(Color(red: 247/225, green: 239/255, blue: 247/255))
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(upcomingEventsData, id: \.self) { event in
                            EventCard(event: event)
                        }
                        .padding(.horizontal, 20)
                        .padding(.trailing, -20)
                    }
                }
            }
            //.background(Color(red: 250/255, green: 244/255, blue: 250/255))
            .frame(width: 400)
            //.background(Color(red: 247/225, green: 239/255, blue: 247/255))
            //.position(CGPoint(x: 180.0, y: 350.0))
            //.navigationBarHidden(true)
            //.padding(.horizontal, 16)
            .overlay(
                MenuView(isMenuExpanded: $isMenuExpanded)
                    .frame(width: isMenuExpanded ? UIScreen.main.bounds.width : 0)
                    .background(Color.white)
                    .offset(x: isMenuExpanded ? 0 : -UIScreen.main.bounds.width)
            )
            .overlay(
                CreateEvent(selectedCoHosts: .constant([]))
                    .frame(width: isAddEventPresented ? UIScreen.main.bounds.width : 0)
                    .background(Color.white)
                    .offset(x: isAddEventPresented ? 0 : UIScreen.main.bounds.width)
            )
           .padding(.bottom, 40)
            
            .toolbar {
              ToolbarItem(placement: .bottomBar) {
                HStack {  // Wrap the content in HStack
                  //Spacer()  // Add Spacer to push content to the right
                  Toolbar()
                }
              }
            }
            
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        UserHomeView(username: "YourUsernameHere")
    }
}
