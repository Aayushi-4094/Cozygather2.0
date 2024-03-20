//import SwiftUI
//
//struct FilterScreen: View {
//    var body: some View {
//        VStack {
//            Text("Filter")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//            
//            VFilterOptionsView()
//            
//            Spacer()
//            
//            VFilterActionButtonsView()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.white)
//        .cornerRadius(30)
//        .padding()
//    }
//}
//
//struct VFilterOptionsView: View {
//    var body: some View {
//        VStack {
//            HStack {
//                VFilterOptionButtonView(label: "Completed orders", icon: "checkmark.circle.fill")
//                   
//                VFilterOptionButtonView(label: "Pending orders", icon: "clock.fill")
//                    
//            }
//            .padding(.bottom)
//            
//            VStack(alignment: .leading) {
//                Text("Categories")
//                    .font(.headline)
//                    .padding(.top, 20)
//                    .padding(.horizontal)
//                CategoriesView()
//            }
//            
//            VFilterDateSelectionView()
//            
//            VFilterLocationSelectionView()
//            
//            VFilterPriceRangeView()
//        }
//        .padding()
//    }
//}
//
//struct VFilterOptionButtonView: View {
//    var label: String
//    var icon: String
//    
//    var body: some View {
//        Button(action: {}) {
//            VStack {
//                Image(systemName: icon)
//                    .font(.title)
//                    .foregroundColor(.blue)
//                Text(label)
//                    .font(.caption)
//            }
//            .frame(maxWidth: .infinity)
//        }
//        .padding()
//        .cornerRadius(10)
//    }
//}
//
//struct VFilterDateSelectionView: View {
//    var body: some View {
//        HStack {
//            Text("Date")
//                .font(.caption)
//            Spacer()
//            VDateSelectionButtonView(label: "Select from Calendar")
//        }
//        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct VDateSelectionButtonView: View {
//    var label: String
//    
//    var body: some View {
//        Button(action: {}) {
//            Text(label)
//                .font(.caption)
//                .foregroundColor(.blue)
//        }
//    }
//}
//
//struct VFilterLocationSelectionView: View {
//    var body: some View {
//        HStack {
//            Text("Location")
//                .font(.caption)
//            Spacer()
//            Text("Choose")
//                .font(.caption)
//                .foregroundColor(.blue)
//            Image(systemName: "chevron.right")
//                .foregroundColor(.blue)
//        }
//        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct VFilterPriceRangeView: View {
//    @State private var lowerPrice = 20.0
//    @State private var upperPrice = 100.0
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Select price range")
//                .font(.caption)
//            HStack {
//                Text("₹\(Int(lowerPrice))")
//                Slider(value: $lowerPrice, in: 0...upperPrice, step: 1.0)
//                Text("₹\(Int(upperPrice))")
//            }
//        }
//        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct CategoriesView: View {
//    var body: some View {
//        HStack {
//            Spacer()
//            Bakery()
//            Spacer()
//            Decor()
//            Spacer()
//            Music()
//            Spacer()
//            Food()
//            Spacer()
//        }
//        .padding(.horizontal)
//    }
//}
//
//struct VFilterActionButtonsView: View {
//    var body: some View {
//        HStack {
//            Spacer()
//            Button(action: {}) {
//                Text("RESET")
//                    .fontWeight(.bold)
//                    .foregroundColor(.red)
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.gray.opacity(0.2))
//            .cornerRadius(10)
//            Spacer()
//            Button(action: {}) {
//                Text("APPLY")
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.blue)
//            .cornerRadius(10)
//            Spacer()
//        }
//    }
//}
//
//struct Bakery: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "birthday.cake")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Bakery")
//                .font(.caption)
//        }
//    }
//}
//
//struct Decor: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "snowflake")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Decor")
//                .font(.caption)
//        }
//    }
//}
//
//struct Music: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "music.note")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Music")
//                .font(.caption)
//        }
//    }
//}
//
//struct Food: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "fork.knife.circle")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Food")
//                .font(.caption)
//        }
//    }
//}
//
//struct FilterScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterScreen()
//    }
//}
