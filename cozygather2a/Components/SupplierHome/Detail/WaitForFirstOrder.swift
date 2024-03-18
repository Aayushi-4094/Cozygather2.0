import SwiftUI

struct WaitForFirstOrder: View {
    @State private var isVendorHomeActive = false
    
    var body: some View {
        VStack {
            Text("You are in!!! Wait for your first order")
                .font(Font.custom("AirbnbCereal_W_Md", size: 40))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                .frame(width: 284, alignment: .center)
                .padding()

            Button(action: {
                isVendorHomeActive.toggle()
            }) {
                HStack(alignment: .center, spacing: 4) {
                    Text("Go to Home Page")
                        .font(Font.custom("YourCustomFont", size: 16))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .frame(width: 211, alignment: .center)
                .background(Color(red: 0.34, green: 0.41, blue: 1))
                .cornerRadius(12)
            }
            .fullScreenCover(isPresented: $isVendorHomeActive) {
                VendorHomePage()
            }
        }
    }
}

struct WaitForFirstOrder_Previews: PreviewProvider {
    static var previews: some View {
        WaitForFirstOrder()
    }
}
