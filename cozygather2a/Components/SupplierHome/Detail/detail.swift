import SwiftUI

struct detail: View {
    @State private var emailText = ""
    @State private var phoneNumber = ""
    @State private var emailAddress = ""
    @State private var address = ""
    @State private var services = ""
    @State private var isToggleOn = false
    @State private var selectedServiceIndex = 0
    private let servicesList = ["Catering", "Bakery", "Music", "Decor"]
    @State private var isPopoverVisible = false
    @State private var selectedService = "Services"
    @State private var isWaitingForFirstOrder = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Details")
                .font(Font.custom("AirbnbCereal_W_Md", size: 35))
                .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                .padding(.bottom, 100)
                .offset(y: 50)
            
            VStack(alignment: .leading, spacing: 20) {
                TextField("Full Name", text: $emailText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Phone Number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email Address", text: $emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Text("$")
                    Toggle("Open to fixable rate", isOn: $isToggleOn)
                }
                
                Button(action: {
                    isPopoverVisible.toggle()
                }) {
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundColor(.blue)
                        Text(selectedService)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    .position(CGPoint(x: 165.0, y: 10.0))
                }
                .popover(isPresented: $isPopoverVisible, arrowEdge: .bottom) {
                    VStack {
                        ForEach(servicesList, id: \.self) { service in
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
            }
            .padding()
            
            Button(action: {
                isWaitingForFirstOrder = true
            }) {
                Text("Fill In The Details")
                    .font(Font.custom("YourCustomFont", size: 16))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .frame(width: 211, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 1)
            }
            .fullScreenCover(isPresented: $isWaitingForFirstOrder) {
                WaitForFirstOrder()
            }
            
            Spacer()
        }
    }
}

struct detail_Previews: PreviewProvider {
    static var previews: some View {
        detail()
    }
}

