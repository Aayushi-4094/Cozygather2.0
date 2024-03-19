//import SwiftUI
//
//struct SelectCoHost: View {
//    @State private var coHostName: String = ""
//    @State private var searchText: String = ""
//    @State private var selectedCoHosts: [String] = []
//    @Environment(\.presentationMode) var presentationMode
//    var onCoHostsSelected: ([String]) -> Void
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    Section(header: Text("Select Co-Host")) {
//                        SearchBar(text: $searchText, placeholder: "Search Co-Host")
//
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 16) {
//                                ForEach(0..<3) { index in
//                                    VStack {
//                                        Image("Avatar Image-\(index + 1)")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: 80, height: 80)
//                                            .fixedSize() // Keep the frame size fixed
//                                            .clipShape(Circle())
//                                            .overlay(
//                                                Circle()
//                                                    .stroke(Color.blue, lineWidth: 2)
//                                                    .overlay(
//                                                        Button(action: {
//                                                            let selectedHost = "Avatar Image-\(index + 1)"
//                                                            if !selectedCoHosts.contains(selectedHost) {
//                                                                selectedCoHosts.append(selectedHost)
//                                                            }
//                                                        }) {
//                                                            Image(systemName: "plus.circle.fill")
//                                                                .font(.system(size: 20))
//                                                                .foregroundColor(.green)
//                                                        }
//                                                        .padding(10)
//                                                    )
//                                            )
//                                            .shadow(radius: 5)
//
//                                        Text("Avatar Image-\(index + 1)")
//                                            .foregroundColor(.black)
//                                            .padding(.top, 4)
//                                    }
//                                }
//                            }
//                            .padding()
//                        }
//                        .frame(height: 120)
//
//                        ForEach(selectedCoHosts, id: \.self) { coHost in
//                            HStack {
//                                Text("\(coHost) added as a co-host")
//                                    .foregroundColor(.green)
//
//                                Button(action: {
//                                    if let index = selectedCoHosts.firstIndex(of: coHost) {
//                                        selectedCoHosts.remove(at: index)
//                                    }
//                                }) {
//                                    Image(systemName: "x.circle.fill")
//                                        .font(.system(size: 20))
//                                        .foregroundColor(.red)
//                                }
//                            }
//                            .padding()
//                        }
//                    }
//
//                    Section(header: Text("Share Options")) {
//                        HStack {
//                            Image("Airdrop")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 70, height: 70)
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                            
//                            Spacer()
//                            
//                            Image("Messages")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 70, height: 70)
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                            
//                            Spacer()
//                            
//                            Image("Mail")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 70, height: 70)
//                                .clipShape(RoundedRectangle(cornerRadius: 5))
//                        }
//                        .foregroundColor(.blue)
//                        .padding()
//                        
//                    }
//
//                    Section(header: Text("Copy Link")) {
//                                            HStack {
//                                                Text("Copy the link")
//                                                    .font(.headline)
//                                                    .foregroundColor(.black)
//
//                                                Spacer()
//
//                                                Image(systemName: "doc.on.doc")
//                                                    .font(.title)
//                                            }
//                                            .padding(.horizontal)
//                                            .background(RoundedRectangle(cornerRadius: 10)
//                                                    .foregroundColor(.white)
//                                            )
//                                        }
//                }
//                Button("Done") {
//                                    onCoHostsSelected(selectedCoHosts)
//                                    presentationMode.wrappedValue.dismiss() // Dismiss the current view
//                                }
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                                .padding()
//                            }
//                            .navigationBarTitle("Select Co-Host", displayMode: .inline)
//                            .navigationBarItems(trailing: Button(action: {
//                                presentationMode.wrappedValue.dismiss() // Handle the back action
//                            }) {
//                                Image(systemName: "multiply")
//                                    .font(.title)
//                                    .padding()
//                            })
//                        }
//                    }
//                }
//
//
//                struct SelectCoHost_Previews: PreviewProvider {
//                    static var previews: some View {
//                        SelectCoHost(onCoHostsSelected: {_ in })
//                    }
//                }
//
//                struct SearchBar: View {
//                    @Binding var text: String
//                    var placeholder: String
//
//                    var body: some View {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                                .padding(.leading, 10)
//
//                            TextField(placeholder, text: $text)
//                                .padding(.vertical, 8)
//                        }
//                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
//                        .padding(.horizontal)
//                    }
//                }
