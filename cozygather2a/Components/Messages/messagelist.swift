import SwiftUI

struct messagelist: View {
    @State private var numberOfMessages = 4 // Initial number of messages

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Text("Messages")
                        .font(.title)
                        .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                        .padding(.bottom, 20)
                    Spacer()
//                    Button(action: {}) {
//                        Image(systemName: "bell")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                    }
                }
                .padding(.top, 20) // Align top bar to the top
                Divider()

                ForEach(0..<numberOfMessages, id: \.self) { index in
                    NavigationLink(destination: MessagingView()) {
                        MessageBoxSampleView(imageName: "noti\(index + 1)", name: "Notification \(index + 1)", date: "Jan \(Int.random(in: 1...31))", description: "Sample description", timeButtonText: "\(Int.random(in: 1...60))")
                    }
                }
                .padding(.top, 20) // Align notifications to the top

                Button(action: {
                    numberOfMessages += 1 // Increase the number of messages by 1
                }) {
                    Text("Load More Messages") // Updated button label
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            .background(Color.white)
            .navigationBarHidden(true)

            // Add VendorToolbar at the end of the page
            .toolbar {
              ToolbarItem(placement: .bottomBar) {
                HStack {  // Wrap the content in HStack
                  Spacer()  // Add Spacer to push content to the right
                  VendorToolbar()
                }
              }
            }
        }
    }
}

struct MessageBoxSampleView: View {
    let imageName: String
    let name: String
    let date: String
    let description: String
    let timeButtonText: String

    var body: some View {
        HStack(alignment:.top) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width :70, height :70)
                .cornerRadius(100.0)

            VStack(alignment:.leading) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(description)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment:.trailing) {
                Text(date)
                Text("\(timeButtonText) min ago")
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .frame(width :50,height :50)
            }
        }
        .padding()
    }
}





struct messagelist_Previews : PreviewProvider {
    static var previews : some View {
        messagelist()
    }
}
