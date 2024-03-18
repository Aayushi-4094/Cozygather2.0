import SwiftUI

struct BudgetApp: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        BudgetHeaderView(budget: "₹1,345", forecast: "₹2,010")
                        CostGraphView()
                        TransactionListView(transactions: sampleTransactions)
                    }
                    .padding() // Added padding for better visibility
                }
                .navigationTitle("My budget")
                .background(Color(red: 250/225, green: 244/255, blue: 250/255))
            }
            
            
            // Add the Toolbar at the bottom of the screen
            .overlay(
                VStack {
                    Spacer()
                    Toolbar()
                        .background(Color.white)
                        .frame(height: 0) // Set the height of the toolbar
                }
            )
        }// Background color
    }
}
struct BudgetHeaderView: View {
  let budget: String
  let forecast: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(budget)
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255)) // Text color

      Text("Birthady Bash \(forecast)")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .padding()
  }
}

struct CostGraphView: View {
    let cateringExpenditure: Double = 450 // Replace with actual expenditure for catering
    let decorationExpenditure: Double = 790 // Replace with actual expenditure for decoration
    let vendorsExpenditure: Double = 150 // Replace with actual expenditure for vendors

    var body: some View {
        VStack {
            Text("Spending Chart")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top)

            // Custom birthday bash spending graph
            HStack(spacing: 10) {
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: calculateBarHeight(expenditure:  cateringExpenditure))
                }

                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.green)
                        .frame(height: calculateBarHeight(expenditure: decorationExpenditure))
                }

                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.orange)
                        .frame(height: calculateBarHeight(expenditure: vendorsExpenditure))
                }
            }

//            HStack {
//                Text("June 15, 2020")
//                    .font(.headline)
//                    .padding(.leading)
//                Spacer()
//            }
        }
        .padding()
    }

    func calculateBarHeight(expenditure: Double) -> CGFloat {
        let maxHeight: CGFloat = 150 // Adjust the maximum height as needed
        let percentageSpent = min(expenditure / 1000, 1.0) // Assuming a maximum expenditure of 1000, adjust accordingly
        return maxHeight * CGFloat(percentageSpent)
    }
}


struct TransactionListView: View {
  let transactions: [Transaction]

  var body: some View {
    ForEach(transactions) { transaction in
      HStack {
        Image(systemName: "circle.fill")
          .foregroundColor(transaction.iconColor)
        VStack(alignment: .leading) {
          Text(transaction.title)
            .font(.headline)
//          Text(transaction.subtitle)
//            .font(.subheadline)
//            .foregroundColor(.gray)
        }
        Spacer()
        Text(transaction.amount)
          .foregroundColor(transaction.amount.contains("-") ? .red : .green)
      }
      .padding()
    }
  }
}

struct Transaction: Identifiable {
  let id = UUID()
  let iconColor: Color
  let title: String
  //let subtitle: String
  let amount: String
}

let sampleTransactions = [
  Transaction(iconColor: .blue, title: "Catering",/*subtitle: "Outcoming transfer",*/ amount: "₹450"),
  Transaction(iconColor: .orange, title: "Decoration", /*subtitle: "Annual withdrawal of funds", */amount: "₹790"),
  Transaction(iconColor: .red, title: "Vendors", /*subtitle: "Annual withdrawal of funds", */amount: "-₹150"),
  Transaction(iconColor: .purple, title: "Music",/* subtitle: "Annual withdrawal of funds",*/ amount: "-₹990")
]

//// Placeholder for the actual image loading from Unsplash
//struct UnsplashImageLoader {
//  static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
//    guard let url = URL(string: urlString) else {
//      completion(nil)
//      return
//    }
//    URLSession.shared.dataTask(with: url) { data, response, error in
//      guard let data = data, error == nil else {
//        completion(nil)
//        return
//      }
//      completion(UIImage(data: data))
//    }.resume()
//  }
//}

struct BudgetApp_Previews: PreviewProvider {
  static var previews: some View {
    BudgetApp()
  }
}
