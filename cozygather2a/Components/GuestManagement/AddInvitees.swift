//
//  AddInvitees.swift
//  cozygather2a
//
//  Created by user2batch2 on 30/03/24.
//

import SwiftUI
import MessageUI
import ContactsUI

class MailComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
    var coHostsViewModel: CoHostsViewModel

    init(coHostsViewModel: CoHostsViewModel) {
        self.coHostsViewModel = coHostsViewModel
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .sent {
            // If the user clicked "Yes" in the email, add them as a co-host
            coHostsViewModel.addCoHost("New Co-Host Name")
        }

        controller.dismiss(animated: true, completion: nil)
    }
}

struct AddInvitees: View {
    @State private var showingContacts = false
    @State private var contacts: [CNContact] = []
    @ObservedObject var coHostsViewModel = CoHostsViewModel()

    // Initialize mailComposerDelegate here
    private let mailComposerDelegate = MailComposerDelegate(coHostsViewModel: CoHostsViewModel())

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 250/225, green: 244/255, blue: 250/255) // Set background color
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button("Select from Contacts") {
                            self.showingContacts = true
                        }
                        .padding()
                        
                        Button("Send Invite") {
                            let recipients = self.contacts.compactMap { $0.emailAddresses.first?.value as String? }
                            if !recipients.isEmpty {
                                self.sendEmail(to: recipients)
                            } else {
                                print("No email addresses found")
                            }
                        }
                        .padding()
                    }
                    if !contacts.isEmpty {
                        List(contacts, id: \.identifier) { contact in
                            Text("\(contact.givenName) \(contact.familyName)")
                        }
                    }
                }
                
            }
            .navigationBarTitle("Add Guests")
            .background(Color(red: 250/225, green: 244/255, blue: 250/255)) // Set background color
            
        }
        .fullScreenCover(isPresented: $showingContacts) {
            AddInviteesView(contacts: self.$contacts)
                .background(Color(red: 250/225, green: 244/255, blue: 250/255)) // Set background color
        }
    }
    
    func sendEmail(to recipients: [String]) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Device cannot send email")
            return
        }

        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = mailComposerDelegate
        mailComposer.setToRecipients(recipients)
        mailComposer.setSubject("Invitation to Event") // Set subject of the email

        // Set the body of the email with links for the recipient to respond with Yes or No
        let body = """
        You are invited to the event. Please respond with your choice:
        <a href="mailto:youremail@example.com?subject=Response%20to%20Co-Host%20Invitation&body=Yes">Yes</a>
        <br>
        <a href="mailto:youremail@example.com?subject=Response%20to%20Co-Host%20Invitation&body=No">No</a>
        """
        mailComposer.setMessageBody(body, isHTML: true)

        UIApplication.shared.windows.first?.rootViewController?.present(mailComposer, animated: true, completion: nil)
    }

    func showCoHosts() {
        // Display the list of selected co-hosts
        // You can implement this functionality here
        // For example:
        // NavigationLink(destination: CoHostsView(coHosts: coHostsViewModel.coHosts)) {
        //    Text("Selected Co-Hosts")
        // }
    }
}


struct AddInviteesView: UIViewControllerRepresentable {
    @Binding var contacts: [CNContact]

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let controller = CNContactPickerViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(contacts: $contacts)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        @Binding var contacts: [CNContact]

        init(contacts: Binding<[CNContact]>) {
            _contacts = contacts
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            self.contacts = contacts
        }
    }
}

struct AddInvitees_Previews: PreviewProvider {
    static var previews: some View {
        AddInvitees()
    }
}
