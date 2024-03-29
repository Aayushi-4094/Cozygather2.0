// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
       
        NavigationView {
            ZStack{
//                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color(red:67/255, green:13/255, blue:75/255).opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 0) {
                    NavigationLink(destination: SecondScreen()) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 393, height: 251)
                            .background(
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                            )
                    }
                }
                .padding(.horizontal, 0)
                .padding(.top, 245)
                .padding(.bottom, 356)
                .frame(width: 393, height: 852, alignment: .top)
                //.background(Color(red: 247/225, green: 239/255, blue: 247/255))
                .cornerRadius(48)
                .navigationBarHidden(true)
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
