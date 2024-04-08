import SwiftUI

struct BudgetApp: View {
    let expenditures = [
        Expenditure(category: "Catering", amount: 450, iconColor: .blue),
        Expenditure(category: "Decoration", amount: 790, iconColor: .green),
        Expenditure(category: "Vendors", amount: 150, iconColor: .orange),
        Expenditure(category: "Music", amount: 990, iconColor: .purple)
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        BudgetHeaderView(budget: "₹1,345", forecast: "₹2,010")
                        CostGraphView(expenditures: expenditures)
                        TransactionListView(transactions: sampleTransactions)
//                        NavigationLink(destination: BudgetEventDetailView() {
//                            Text("Go to Budgeting Screen")
//                                .foregroundColor(.blue)
//                        })
                  }
                    .padding() // Added padding for better visibility
                }
                .navigationTitle("My budget")
                .background(Color(red: 247/255, green: 239/255, blue: 247/255))
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Toolbar()
                    }
                    .offset(y:20)
                }
            }
            
        }
        .background(Color(red: 247/255, green: 239/255, blue: 247/255))
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
                .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255)) // Text color

            Text("Birthady Bash \(forecast)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct CostGraphView: View {
    let expenditures: [Expenditure]

    var body: some View {
        VStack {
            Text("Spending Chart")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top)

            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(expenditures, id: \.category) { expenditure in
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(expenditure.iconColor)
                                .frame(width: 50, height: calculateBarHeight(expenditure: expenditure.amount))
                            Text(expenditure.category)
                                .rotationEffect(.degrees(-90))
                        }
                    }
                }
                .padding()
            }
        }
        .padding()
    }
    
    func calculateBarHeight(expenditure: Int) -> CGFloat {
        let maxHeight: CGFloat = 150 // Adjust the maximum height as needed
        let percentageSpent = min(Double(expenditure) / 1000, 1.0) // Assuming a maximum expenditure of 1000, adjust accordingly
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
                }
                Spacer()
                Text(transaction.amount)
                    .foregroundColor(transaction.amount.contains("-") ? .red : .green)
            }
            .padding()
        }
    }
}

struct Expenditure {
    let category: String
    let amount: Int
    let iconColor: Color
}

struct Transaction: Identifiable {
    let id = UUID()
    let iconColor: Color
    let title: String
    let amount: String
}

let sampleTransactions = [
    Transaction(iconColor: .blue, title: "Catering", amount: "₹450"),
    Transaction(iconColor: .green, title: "Decoration", amount: "₹790"),
    Transaction(iconColor: .orange, title: "Vendors", amount: "₹150"),
    Transaction(iconColor: .purple, title: "Music", amount: "₹990")
]

struct BudgetApp_Previews: PreviewProvider {
    static var previews: some View {
        BudgetApp()
    }
}
