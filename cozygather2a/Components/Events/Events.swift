import SwiftUI

struct Events: View {
    @State private var selectedTab: EventsTab = .upcoming
    
    enum EventsTab {
        case upcoming, past, cancelled
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    // Add action for the back button
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.blue)
                }.position(CGPoint(x: 30.0, y: 40.0))

                Label("Events", systemImage: "")
                    .font(Font.custom("AirbnbCereal_W_Md", size: 24))
                    .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    .position(CGPoint(x: 10.0, y: 40.0))

                
            }
            .background(Color.white)
            .navigationBarHidden(true)

            HStack(spacing: 20) {
                CustomButton(title: "Upcoming", isSelected: selectedTab == .upcoming) {
                    selectedTab = .upcoming
                }
                .position(CGPoint(x: 72.0, y: 110.0))
                .frame(width: 120)
                
                CustomButton(title: "Past", isSelected: selectedTab == .past) {
                    selectedTab = .past
                }
                .position(CGPoint(x: 22.0, y: 110.0))

                CustomButton(title: "Cancelled", isSelected: selectedTab == .cancelled) {
                    selectedTab = .cancelled
                }
                .position(CGPoint(x: 10, y: 110))
                .frame(width: 120)
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .position(CGPoint(x: 200.0, y: -140.0))

            VStack(spacing: 20) {
                CustomManageBox(imageName: "venrd1", date: "24 jan 2024", description: "hi", hyperlinkText: "view details")
                CustomManageBox(imageName: "venrd1", date: "24 jan 2024", description: "hi", hyperlinkText: "view details")
                
            }
            .padding()
            .background(Color.white)
            .padding(.top, 0)
            .frame(maxWidth: .infinity)
            .position(CGPoint(x: 190.0, y: -220.0))
        }
    }
}

struct CustomButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .white : .black)
                .padding()
                .background(isSelected ? Color.blue : Color.white)
                .cornerRadius(8)
        }
    }
}

struct Events_Preview: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
