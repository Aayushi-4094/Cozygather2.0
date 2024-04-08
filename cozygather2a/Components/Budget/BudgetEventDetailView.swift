//////import SwiftUI
//////
//////struct BudgetEventDetailView: View {
//////    @ObservedObject var firestoreManager = FirestoreManager.shared
//////    @State private var isPickerVisible = false
//////    @State private var selectedEventIndex = 0
//////    @State private var events: [Event] = []
//////    @State private var isLoading = false
//////
//////    var body: some View {
//////        VStack {
//////            Button(action: {
//////                isPickerVisible.toggle()
//////            }) {
//////                Text("Select Event")
//////                    .padding()
//////            }
//////            
//////            if isPickerVisible {
//////                if isLoading {
//////                    ProgressView()
//////                } else {
//////                    Picker(selection: $selectedEventIndex, label: Text("Select Event")) {
//////                        ForEach(0..<events.count, id: \.self) { index in
//////                            Text(events[index].eventName)
//////                        }
//////                    }
//////                    .pickerStyle(MenuPickerStyle())
//////                    .padding()
//////
//////                    if let selectedEvent = events[safe: selectedEventIndex] {
//////                        EventDetailsView(event: selectedEvent)
//////                    } else {
//////                        Text("No event selected")
//////                    }
//////                }
//////            }
//////        }
//////        .onAppear {
//////            isLoading = true
//////            fetchEvents()
//////        }
//////    }
//////
//////    private func fetchEvents() {
//////        firestoreManager.fetchEvents { events in
//////            self.events = events
//////            isLoading = false
//////        }
//////    }
//////}
//////
//////struct EventDetailsView: View {
//////    let event: Event
//////
//////    var body: some View {
//////        VStack(alignment: .leading) {
//////            Text("Event Name: \(event.eventName)")
//////            Text("Venue Address: \(event.venueAddress)")
//////            Text("Initial Price: \(event.initialPrice)")
//////            // Add other event details here
//////        }
//////        .padding()
//////    }
//////}
//////
//////struct BudgetEventDetailView_Previews: PreviewProvider {
//////    static var previews: some View {
//////        BudgetEventDetailView()
//////    }
//////}
//////
//////extension Collection {
//////    subscript(safe index: Index) -> Element? {
//////        indices.contains(index) ? self[index] : nil
//////    }
//////}
////import SwiftUI
////
////struct BudgetEventDetailView: View {
////    @ObservedObject var firestoreManager = FirestoreManager.shared
////    @State private var isPickerVisible = false
////    @State private var selectedEventIndex = 0
////    @State private var events: [Event] = []
////    @State private var isLoading = false
////    @State private var bookedVendors: [VendorDetails] = []
////
////    var body: some View {
////        VStack {
////            Button(action: {
////                isPickerVisible.toggle()
////            }) {
////                Text("Select Event")
////                    .padding()
////            }
////            
////            if isPickerVisible {
////                if isLoading {
////                    ProgressView()
////                } else {
////                    Picker(selection: $selectedEventIndex, label: Text("Select Event")) {
////                        ForEach(0..<events.count, id: \.self) { index in
////                            Text(events[index].eventName)
////                        }
////                    }
////                    .pickerStyle(MenuPickerStyle())
////                    .padding()
////
////                    if let selectedEvent = events[safe: selectedEventIndex] {
////                        EventDetailsView(event: selectedEvent, bookedVendors: bookedVendors)
////                            .onAppear {
////                                fetchBookedVendors(for: selectedEvent)
////                            }
////                    } else {
////                        Text("No event selected")
////                    }
////                }
////            }
////        }
////        .onAppear {
////            isLoading = true
////            fetchEvents()
////        }
////    }
////
////    private func fetchEvents() {
////        firestoreManager.fetchEvents { events in
////            self.events = events
////            isLoading = false
////        }
////    }
////    
////    private func fetchBookedVendors(for event: Event) {
////        guard let eventID = event.id else { return }
////        firestoreManager.fetchBookedVendorsForEvent(eventID: eventID) { vendors in
////            self.bookedVendors = vendors
////        }
////    }
////}
////
////
////struct EventDetailsView: View {
////    let event: Event
////    let bookedVendors: [VendorDetails]
////
////    var body: some View {
////        VStack(alignment: .leading) {
////            Text("Event Name: \(event.eventName)")
////            Text("Venue Address: \(event.venueAddress)")
////            Text("Initial Price: \(event.initialPrice)")
////            
////            if !bookedVendors.isEmpty {
////                Text("Booked Vendors:")
////                ForEach(bookedVendors) { vendor in
////                    VStack(alignment: .leading) {
////                        Text("Category: \(vendor.selectedCategory ?? "")")
////                        Text("Price: \(vendor.price)")
////                    }
////                }
////            } else {
////                Text("No booked vendors for this event")
////            }
////        }
////        .padding()
////    }
////}
////
////
////struct BudgetEventDetailView_Previews: PreviewProvider {
////    static var previews: some View {
////        BudgetEventDetailView()
////    }
////}
////
////extension Collection {
////    subscript(safe index: Index) -> Element? {
////        indices.contains(index) ? self[index] : nil
////    }
////}
//// BudgetEventDetailView.swift
//
//import SwiftUI
//
//struct BudgetEventDetailView: View {
//    @ObservedObject var firestoreManager = FirestoreManager.shared
//    @State private var event: Event?
//    @State private var isLoading = false
//    
//    let eventName: String
//    
//    var body: some View {
//        VStack {
//            if isLoading {
//                ProgressView()
//            } else if let event = event {
//                Text("Event Name: \(event.eventName)")
//                Text("Initial Price: \(event.initialPrice)")
//                if let bookedVendors = event.bookedVendors, !bookedVendors.isEmpty {
//                    Text("Booked Vendors:")
//                    ForEach(bookedVendors) { eventStatistic in
//                        VStack(alignment: .leading) {
//                            Text("- \(eventStatistic.eventName)")
//                            Text("Total Booked Vendors: \(eventStatistic.totalBookedVendors)")
//                            if !eventStatistic.bookedVendors.isEmpty {
//                                Text("Booked Vendor Categories:")
//                                ForEach(eventStatistic.bookedVendors.sorted(by: { $0.key < $1.key }), id: \.key) { category, price in
//                                    Text("\(category): \(price)")
//                                }
//                            }
//                        }
//                    }
//                } else {
//                    Text("No booked vendors for this event")
//                }
//            } else {
//                Text("Event not found")
//            }
//        }
//        .onAppear {
//            isLoading = true
//            fetchEventDetails()
//        }
//    }
//    
//    private func fetchEventDetails() {
//        firestoreManager.fetchEventDetails(forEvent: eventName) { event in
//            self.event = event
//            isLoading = false
//        }
//    }
//}
//
//struct BudgetEventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetEventDetailView(eventName: "Your_Event_Name")
//    }
//}
//import SwiftUI
//
//struct BudgetEventDetailView: View {
//    let event: Event
//    let bookedVendor: VendorDetails? // Optional because a vendor may not be booked yet
//    
//    var body: some View {
//        VStack {
//            Text("Event Details")
//                .font(.title)
//                .padding()
//            
//            Text("Event Name: \(event.eventName)")
//            Text("Venue Address: \(event.venueAddress)")
//            Text("Initial Price: \(event.initialPrice)")
//            Text("Selected Date: \(event.selectedDate)")
//            Text("Selected Co-Hosts: \(event.selectedCoHosts.joined(separator: ", "))")
//            
//            if let bookedVendor = bookedVendor {
//                Text("Booked Vendor Details")
//                    .font(.title)
//                    .padding()
//                
//                Text("Shop Name: \(bookedVendor.shopName)")
//                Text("Address: \(bookedVendor.address)")
//                Text("Price: \(bookedVendor.price)")
//                Text("Hours: \(bookedVendor.hours)")
//                Text("Selected Category: \(bookedVendor.selectedCategory ?? "")")
//            }
//        }
//        .padding()
//    }
//}
//struct BudgetEventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetEventDetailView()
//    }
//}
import SwiftUI

struct BudgetEventDetailView: View {
    
    var body: some View {
        ZStack{
           
            VStack {

                Text("Budgeting")
                    .font(.title)
                    .fontWeight(.bold)
                    Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack{
                        Text("Event Name")
                        Image(systemName: "chevron.down")
                            .frame(width:20, height: 5)
                    }
                    Text("Initial Budget: ₹10000.00")
                    
                    Text("Total Price (Predicted): ₹13000.00")
                }
                
                Image("Budget")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                // Breakdown of Expenses
                VStack(alignment: .leading, spacing: 10) {
                    Text("Breakdown of Expenses:")
                        .font(.headline)
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.yellow)
                        Text("Decor Vendor Price: ₹1000.00")
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.yellow)
                        Text("Bakery Vendor Price: ₹4000.00")
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.yellow)
                        Text("Catering Vendor Price: ₹5000.00")
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.yellow)
                        Text("Music Vendor Price: ₹3000.00")
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.blue)
                        Text("Ideal Decor Rate: ₹769.23")
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.blue)
                        Text("Ideal Bakery Rate: ₹3076.92")
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.blue)
                        Text("Ideal Catering Rate: ₹3846.15")
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .frame(width:5, height:5 )
                            .foregroundColor(.blue)
                        Text("Ideal Music Rate: ₹2307.69")
                    }
                }
                .padding()
                .cornerRadius(10)
                .padding()
                
                
                
            }
            
        } .background(Color(red: 247/225, green: 239/255, blue: 247/255))
      
       
    }
}

struct BudgetEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEventDetailView()
    }
}
