import SwiftUI

struct FilterScreen1: View {
    var body: some View {
        VStack {
            Text("Filter")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            FilterOptionsView()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .padding()
    }
}


struct FilterOptionsView: View {
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    
    var body: some View {
        VStack {
            HStack {
                FilterOptionButtonView(label: "Completed orders", icon: "checkmark.circle.fill")
                FilterOptionButtonView(label: "Pending orders", icon: "clock.fill")
            }
            .padding(.bottom)
            
            FilterDateTimeSelectionView(selectedDate: $selectedDate, selectedTime: $selectedTime)
            
            FilterLocationSelectionView()
            
            FilterPriceRangeView()
            
            FilterActionButtonsView()
        }
        .padding()
    }
}

struct FilterOptionButtonView: View {
    var label: String
    var icon: String
    
    var body: some View {
        Button(action: {}) {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                Text(label)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .cornerRadius(10)
    }
}


struct FilterDateTimeSelectionView: View {
    @Binding var selectedDate: Date
    @Binding var selectedTime: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("Date")
                    .font(.caption)
                Spacer()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            HStack {
                Text("Time")
                    .font(.caption)
                Spacer()
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

struct FilterLocationSelectionView: View {
    var body: some View {
        HStack {
            Text("Location")
                .font(.caption)
            Spacer()
            Text("Choose")
                .font(.caption)
                .foregroundColor(.blue)
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct FilterPriceRangeView: View {
    @State private var lowerPrice = 20.0
    @State private var upperPrice = 100.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select price range")
                .font(.caption)
            HStack {
                Text("$\(Int(lowerPrice))")
                Slider(value: $lowerPrice, in: 0...upperPrice, step: 1.0)
                Text("$\(Int(upperPrice))")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct FilterActionButtonsView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("RESET")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            Button(action: {}) {
                Text("APPLY")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
}

struct FilterScreen1_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen1()
    }
}
