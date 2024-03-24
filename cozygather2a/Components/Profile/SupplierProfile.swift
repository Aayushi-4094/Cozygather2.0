import SwiftUI

struct SupplierProfile: View {
    @State private var emailText = ""
    @State private var PhoneNumber = ""
    @State private var Location = ""
    @State private var Negotiation = ""
    @State private var isToggleOn = false
    @State private var selectedService = "Services"
    @State private var isPopoverVisible = false

    private let services = ["Catering", "Bakery", "Music", "Decor"]

    var body: some View {
        NavigationView {
        VStack(spacing: 20) {
            // Image and Label
            Image("noti2") // Replace "profileImage" with the name of your asset
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.bottom, 10)
            
            Text("User Name") // Placeholder label
                .font(.headline)
                .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
            
            // Edit Profile Button
            Button("Edit Profile") {
                // Add action for editing profile
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            // Phone Number and Address
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "phone")
                        .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                        .padding(.leading, 10)
                    
                    TextField("Phone Number", text: $PhoneNumber)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color(red: 0.9, green: 0.87, blue: 0.87), lineWidth: 1))
                }
                .padding([.horizontal, .bottom])
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                        .padding(.leading, 10)
                    
                    TextField("Location", text: $Location)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color(red: 0.9, green: 0.87, blue: 0.87), lineWidth: 1))
                }
                .padding([.horizontal, .bottom])
                
                HStack {
                    Toggle("", isOn: $isToggleOn)
                        .labelsHidden()
                    
                    Image(systemName: "dollarsign")
                        .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                        .padding(.leading, 10)
                    
                    Text("Open to negotiation")
                        .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                        .padding(.trailing, 10)
                    
                    Spacer() // Align Toggle to the right
                }
                .padding([.horizontal, .bottom])
            }
            
            // Services
            VStack(spacing: 10) {
                Button {
                    isPopoverVisible.toggle()
                } label: {
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundColor(.blue)
                        Text(selectedService)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                }
                .popover(isPresented: $isPopoverVisible, arrowEdge: .bottom) {
                    VStack {
                        ForEach(services, id: \.self) { service in
                            Button(action: {
                                selectedService = service
                                isPopoverVisible.toggle()
                            }) {
                                Text(service)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                }
                .padding(.bottom, 20)
            }
            .toolbar {
              ToolbarItem(placement: .bottomBar) {
                HStack {  // Wrap the content in HStack
                  Spacer()  // Add Spacer to push content to the right
                  VendorToolbar()
                }
              }
            }
        }
        .padding(.horizontal)
        .background(Color.white)
        .navigationTitle("Profile")
        
    }
    }
}

struct SupplierProfile_Previews: PreviewProvider {
    static var previews: some View {
        SupplierProfile()
    }
}
