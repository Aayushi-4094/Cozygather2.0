import SwiftUI
import Contacts
import MessageUI
class MessageDelegate: NSObject, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Handle message sending result here
        controller.dismiss(animated: true, completion: nil)
    }
}


struct CreateEvent: View {
    @State private var eventName: String = "Event name"
    @State private var venueAddress: String = "Address"
    @State private var price: String = "Price"
    @State private var selectedDateTime = Date()
    @State private var isDateAndTimeVisible = false
    @State private var isEventDetailViewVisible = false
    //@State private var isSelectCoHostVisible = false
    @State private var eventDate = Date()
    @State private var showInvite = false
    //@Binding var selectedCoHosts: [ContactInfo]
    @State private var searchText: String = ""
    @State private var isConfirmEventVisible = false
    @State private var isCoHostSheetPresented = false // Add this state variable
    @Environment(\.presentationMode) var presentationMode
    @State private var isDateAndTimeSheetPresented = false
    @State private var isAlertPresented = false
    @State private var isShowingMessageComposer = false
    @Binding var selectedCoHosts: [ContactInfo]
    @State private var filteredContacts: [CNContact] = []

    
    let messageDelegate = MessageDelegate()
    var isFormValid: Bool {
        return !eventName.isEmpty && !venueAddress.isEmpty && !price.isEmpty //&& !selectedCoHosts.isEmpty
    }
    let staticContacts: [ContactInfo] = [
         ContactInfo(name: "John Doe", phoneNumber: "1234567890"),
         ContactInfo(name: "John Doe", phoneNumber: "1234567890"),
         ContactInfo(name: "John Doe", phoneNumber: "1234567890"),
         ContactInfo(name: "Jane Doe", phoneNumber: "9876543210"),
         // Add more static contacts as needed
     ]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Title Section
                    Image("nametheevent")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    // Event Name Section
                    SectionBox {
                        HStack {
                            Text("Event Name")
                                .font(.headline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))

                            Spacer()

                            TextField("Event Name", text: $eventName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                    }

                    // Co-host Section (Commented out)
                    SectionBox {
                        HStack {
                            Text("Co-host")
                                .font(.headline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                            Spacer()

                            Button(action: {
                                isCoHostSheetPresented.toggle()
                            }) {
                                Text("Select Co-host")
                                    .foregroundColor(.primary)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 1)
                            }
                            .sheet(isPresented: $isCoHostSheetPresented) {
                                ContactListView(selectedContacts: $selectedCoHosts)
                            }
                        }
                    }

                    // Date and Time Section (Commented out)
                    
                    SectionBox {
                        HStack {
                            Text("Date and Time")
                                .font(.headline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                            Spacer()

                            Button(action: {
                                isDateAndTimeVisible.toggle()
                            }) {
                                Text("Select Date and Time")
                                    .foregroundColor(.primary)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 1)
                            }
                            .sheet(isPresented: $isDateAndTimeVisible) {
                                DateAndTime(selectedDate: $selectedDateTime, onDateSelected: { date in
                                    selectedDateTime = date
                                }, isSheetPresented: $isDateAndTimeVisible)
                            }
                        }
                    }
                    // Location Section
                    SectionBox {
                        HStack {
                            Text("Location")
                                .font(.headline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                            Spacer()

                            TextField("Location", text: $venueAddress)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                    }

                    // Budget Section
                    SectionBox {
                        HStack {
                            Text("Budget")
                                .font(.headline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                            Spacer()

                            TextField("Budget", text: $price)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                    }
                    // Generate e-Invite Section
                    SectionBox {
                        HStack {
                            Text("Generate e-Invite")
                                .font(.headline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                            Spacer()

                            Button(action: {
                                sendInvite()
                            }) {
                                Text("Generate")
                                    .foregroundColor(.primary)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 1)
                            }
                        }
                    }
                    
                    SectionBox {
                                       HStack {
                                           Text("Invite")
                                               .font(.headline)
                                               .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                                           Spacer()
                                           
                                           Button(action: {
                                               sendInvite()
                                           }) {
                                               Text("Send Invites")
                                                   .foregroundColor(.primary)
                                                   .padding()
                                                   .background(Color.white)
                                                   .cornerRadius(10)
                                                   .shadow(radius: 1)
                                           }
                                       }
                                       VStack {
                                           ForEach(filteredContacts, id: \.self) { contact in
                                               ContactRow(contact: contact, isSelected: selectedCoHosts.contains { $0.phoneNumber == contact.phoneNumbers.first?.value.stringValue }) {
                                                   toggleSelection(for: contact)
                                               }
                                           }
                                       }
                                   }
                    
                    // Confirm Button Section
                    Button(action: {
                        if isFormValid {
                            // Extract phone numbers from selectedContacts
                            let phoneNumbers = selectedCoHosts.map { $0.phoneNumber }

                            
                            // Create the event with extracted phone numbers
                            let event = Event(eventName: eventName,
                                              venueAddress: venueAddress,
                                              price: price,
                                              selectedDate: selectedDateTime,
                                              selectedCoHosts: phoneNumbers)

                            FirestoreManager.shared.createEvent(event) { success in
                                // Handle the success or failure here
                                if success {
                                    // Event created successfully
                                } else {
                                    // Error creating event
                                }
                            }
                        } else {
                            // Show an alert if the form is not valid
                            isAlertPresented.toggle()
                        }
                    }) {
                        Text("Confirm")
                            .foregroundColor(Color(red: 150/225, green: 100/225, blue: 200/225))
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 82/225, green: 72/255, blue: 159/255))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .shadow(radius: 1)
                    }
                    .padding(.bottom, 20)
                    .alert(isPresented: $isAlertPresented) {
                        Alert(
                            title: Text("Incomplete Details"),
                            message: Text("Please fill in all the details to create an event."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .padding()
            }
            .padding()
            .navigationBarTitle("Create Event", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                        .imageScale(.large)
                }
            )
        }
        .background(Color(red: 250/225, green: 244/255, blue: 250/255))
        .navigationBarHidden(true)
        
    }
    struct SectionBox<Content: View>: View {
            let content: Content

            init(@ViewBuilder content: @escaping () -> Content) {
                self.content = content()
            }

            var body: some View {
                VStack {
                    content
                        .padding()
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
            }
        }

    func sendInvite() {
            guard MFMessageComposeViewController.canSendText() else {
                // Handle if messaging is not available
                return
            }

            let controller = MFMessageComposeViewController()
            controller.body = generateMessageBody()
            controller.recipients = selectedCoHosts.map { $0.phoneNumber }

            // Set the delegate of the message compose view controller
            controller.messageComposeDelegate = messageDelegate

            UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true)
            isShowingMessageComposer = true
        }

        func generateMessageBody() -> String {
            // Generate a message body with the event details and link
            return "Hey there! I'm inviting you to co-host my event: \(eventName) at \(venueAddress) on \(selectedDateTime)"
        }
    func toggleSelection(for contact: CNContact) {
           // Implementation of toggleSelection function
           // This function should modify the selectedCoHosts array based on the contact
           // For example:
           if let index = selectedCoHosts.firstIndex(where: { $0.phoneNumber == contact.phoneNumbers.first?.value.stringValue }) {
               selectedCoHosts.remove(at: index)
           } else {
               if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                   selectedCoHosts.append(ContactInfo(name: "\(contact.givenName) \(contact.familyName)", phoneNumber: phoneNumber))
               }
           }
       }
       

    }

struct ContactListView: View {
    @Binding var selectedContacts: [ContactInfo]
    @State private var contacts: [CNContact] = []
    @State private var filteredContacts: [CNContact] = []
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.horizontal)

            List(filteredContacts, id: \.self) { contact in
                ContactRow(contact: contact, isSelected: self.selectedContacts.contains { $0.phoneNumber == contact.phoneNumbers.first?.value.stringValue }, onTapAction: { self.toggleSelection(for: contact) })
            }
        }
        .onAppear {
            fetchContacts()
        }
        .onChange(of: searchText) { newValue in
            filterContacts()
        }
    }

    func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            if granted && error == nil {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                do {
                    try store.enumerateContacts(with: request) { contact, _ in
                        contacts.append(contact)
                    }
                    filterContacts()
                } catch {
                    print("Error fetching contacts: \(error.localizedDescription)")
                }
            } else {
                print("Contacts access denied")
            }
        }
    }

    func filterContacts() {
        if searchText.isEmpty {
            filteredContacts = contacts
        } else {
            filteredContacts = contacts.filter { contact in
                contact.givenName.localizedCaseInsensitiveContains(searchText) ||
                    contact.familyName.localizedCaseInsensitiveContains(searchText) ||
                    contact.phoneNumbers.contains(where: { $0.value.stringValue.localizedCaseInsensitiveContains(searchText) })
            }
        }
    }

    func toggleSelection(for contact: CNContact) {
        if let index = selectedContacts.firstIndex(where: { $0.phoneNumber == contact.phoneNumbers.first?.value.stringValue }) {
            selectedContacts.remove(at: index)
        } else {
            if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                selectedContacts.append(ContactInfo(name: "\(contact.givenName) \(contact.familyName)", phoneNumber: phoneNumber))
            }
        }
    }
}

struct ContactRow: View {
    var contact: CNContact
    var isSelected: Bool
    var onTapAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(contact.givenName) \(contact.familyName)")
                    .font(.headline)
                if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                    Text(phoneNumber)
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 8)
            Spacer()
            Button(action: {
                onTapAction()
            }) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .green : .blue)
                    .imageScale(.large)
            }
            .padding(.trailing)
        }
        .padding(.horizontal)
    }
}


    struct SearchBar: View {
        @Binding var text: String

        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
    }

    struct CreateEvent_Previews: PreviewProvider {
        static var previews: some View {
            CreateEvent(selectedCoHosts: .constant([]))
        }
    }

    struct ContactInfo {
        var name: String
        var phoneNumber: String
        // Add more properties as needed
    }

extension UIViewController: MFMessageComposeViewControllerDelegate {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Handle message sending result here
        controller.dismiss(animated: true, completion: nil)
    }
}

struct MessageComposer: UIViewControllerRepresentable {
    let recipients: [String]
    let messageBody: String

    func makeCoordinator() -> MessageCoordinator {
        return MessageCoordinator()
    }

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.body = messageBody
        controller.recipients = recipients
        controller.messageComposeDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
        // Update the view controller if needed
    }
}
class MessageCoordinator: NSObject, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Handle message sending result here
        controller.dismiss(animated: true)
    }
}
