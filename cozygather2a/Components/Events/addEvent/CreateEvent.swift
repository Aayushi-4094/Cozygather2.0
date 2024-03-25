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
    @State private var eventName: String = ""
    @State private var venueAddress: String = "Address"
    @State private var price: String = "Price"
    @State private var selectedDateTime = Date()
    @State private var isDateAndTimeVisible = false
    @State private var isCoHostSheetPresented = false
    @State private var isDateAndTimeSheetPresented = false
    @State private var isAlertPresented = false
    @State private var isShowingMessageComposer = false
    @Binding var selectedCoHosts: [ContactInfo]
    @State private var filteredContacts: [CNContact] = []
    @Environment(\.presentationMode) var presentationMode
    
    let messageDelegate = MessageDelegate()
    var isFormValid: Bool {
        return !eventName.isEmpty && !venueAddress.isEmpty && !price.isEmpty
    }
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
                    HStack {
                        Image(systemName: "pencil.circle")
                            .foregroundColor(.primary)
                            .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255))
                        
                        TextField("Event Name", text: $eventName)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                            .cornerRadius(8)
                    }
        
 
                    // Location Section
                   HStack {
                       Image(systemName: "location.fill")
                           .foregroundColor(.primary)
                           .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255))
                       
                        TextField("Location", text: $venueAddress)
                           .padding(.horizontal)
                           .padding(.vertical, 8)
                           .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                           .cornerRadius(8)
                    }
                    
                    // Budget Section
                    HStack {
                        Image(systemName: "rupeesign.circle")
                            .foregroundColor(.primary)
                            .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255))
                        
                        TextField("Budget", text: $price)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                            .cornerRadius(8)
                    }
                    // Co-host Section
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .foregroundColor(.primary)
                            .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255))
                        
                        Button(action: {
                            isCoHostSheetPresented.toggle()
                        }) {
                            HStack {
                                
                                Text("Select Co-host")
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                            .cornerRadius(8)
                        }
                        .sheet(isPresented: $isCoHostSheetPresented) {
                                            ContactListView(selectedContacts: $selectedCoHosts)
                        }
                        .padding(.horizontal)
                    }

                    // Date and Time Section
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.primary)
                            .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255))
                        
                        Button(action: {
                            isDateAndTimeVisible.toggle()
                        }) {
                            HStack {
                                
                                Text(formattedDateTime)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding()
                            .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                            .cornerRadius(8)
                        }
                        .sheet(isPresented: $isDateAndTimeVisible) {
                            DateAndTime(selectedDate: $selectedDateTime, onDateSelected: { date in
                                selectedDateTime = date
                            }, isSheetPresented: $isDateAndTimeVisible)
                        }
                        .padding(.horizontal)
                    }
                
                
                var formattedDateTime: String {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .short
                    return formatter.string(from: selectedDateTime)
                }
            
                    // Generate e-Invite Section
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .foregroundColor(.primary)
                            .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255))
                        
                        Button(action: {
                            sendInvite()
                        }) {
                            Text("Generate e-Invite")
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                                .cornerRadius(8)
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
                            .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 67/225, green: 13/255, blue: 75/255))
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
    @State private var searchText = ""
    @State private var contacts: [ContactInfo] = []

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.horizontal)
            
            List(filteredContacts, id: \.self) { contact in
                ContactRow(contact: contact, isSelected: selectedContacts.contains(contact)) {
                    toggleSelection(for: contact)
                }
            }
            .onAppear {
                fetchContacts()
            }
        }
    }

    var filteredContacts: [ContactInfo] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func fetchContacts() {
        // Fetch contacts from your data source
        // For simplicity, I'll add some mock contacts
        
        // Mock contacts
        let contact1 = ContactInfo(name: "Aayushi Agarwal", phoneNumber: "9068597333")
        let contact2 = ContactInfo(name: "Nilanjana Bhattacharya", phoneNumber: "9897577386")

        contacts = [contact1, contact2]
    }

    func toggleSelection(for contact: ContactInfo) {
        if selectedContacts.contains(contact) {
            selectedContacts.removeAll { $0 == contact }
        } else {
            selectedContacts.append(contact)
        }
    }
}

struct ContactRow: View {
    let contact: ContactInfo
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                HStack {
                    Text("\(contact.name), \(contact.phoneNumber)")
                    Spacer()
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isSelected ? .blue : .gray)
                }
            }
            Text(isSelected ? "Contact selected" : "Contact not selected")
                .font(.caption)
                .foregroundColor(isSelected ? .green : .red)
        }
    }
}
struct ContactInfo: Hashable {
    var name: String
    var phoneNumber: String
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
