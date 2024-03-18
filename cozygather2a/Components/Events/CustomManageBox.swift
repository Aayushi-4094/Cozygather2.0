import SwiftUI

struct CustomManageBox: View {
    var imageName: String
    var date: String
    var description: String
    var hyperlinkText: String

    var body: some View {
        HStack {
            Image(imageName) // Use the custom image name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()

            VStack(alignment: .leading, spacing: 4) {
                Text(date)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(description)
                    .foregroundColor(.gray)


            }
            .padding()

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                

                Button(action: {
                    // Handle button action
                }) {
                    Text(hyperlinkText)
                        .foregroundColor(.blue)
                        .underline()
                        .font(.system(size: 10))

                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding()
    }
}

struct CustomManageBox_Previews: PreviewProvider {
    static var previews: some View {
        CustomManageBox(
            imageName: "venrd1",
            date: "Product Title",
            description: "Product description goes here.",
           
            hyperlinkText: "View Details"
        )
        .previewLayout(.sizeThatFits)
    }
}

