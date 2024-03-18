
import SwiftUI

struct View1: View {
    @State private var isShowingDetailView = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Top Section
                VStack() {
                    Image("vendor1")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                    
                    VStack {
                        HStack {
                            Text("Bakery Name")
                                .font(.title)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                                .padding(.bottom, 4)
                            
                            Spacer()
                            
                            Button(action: {
                                // Handle Book Now action
                            }) {
                                Text("Book Now")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color(red: 82/225, green: 72/255, blue: 159/255))
                                    .cornerRadius(8)
                            }
                        }
                        
                        HStack {
                            Text("⭐️⭐️⭐️⭐️")
                                .font(.subheadline)
                                .foregroundColor(.yellow)
                            
                            Spacer()
                            
                            Text("Starting from")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                            
                            Text("$1200")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Address:")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                        Text("SRM University")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                    }
                    HStack {
                        Text("Hours available:")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                        Text("9 am - 5 pm")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                    }
                    HStack {
                        Text("Phone Number:")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                        Text("98XXXXXXXX")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                    }
                }
                    HStack {
                        Text("Photos")
                            .font(.title)
                            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                        Spacer()
                    }

                    TabView {
                        ForEach(0..<5) { index in
                            Image("menu\(index + 1)")
                                .resizable()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .padding()
                    .frame(width: 300, height: 250)
                }
            }
            .navigationBarTitle("Vendor Details", displayMode: .inline)
            .padding()
            .background(Color(red: 250/225, green: 244/255, blue: 250/255))
        }
//        .background(Color(red: 250/225, green: 244/255, blue: 250/255))
    }


struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1()
    }
}
