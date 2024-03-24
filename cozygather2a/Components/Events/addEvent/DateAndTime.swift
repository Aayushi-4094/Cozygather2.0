import SwiftUI
struct DateAndTime: View {
    @Binding var selectedDate: Date
    var onDateSelected: (Date) -> Void
    @Binding var isSheetPresented: Bool // Add this line

    var body: some View {
        VStack(spacing: 20) {
           //Color(red: 67/255, green: 13/255, blue: 75/255)
            VStack {
                Text("Select Date")
                    .font(.headline)
                    //.background(Color(red: 250/255, green: 244/255, blue: 250/255))
                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .accentColor(Color(red: 198/225, green: 174/255, blue: 128/255))
            
                    
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 67/255, green: 13/255, blue: 75/255), lineWidth: 1))
            
            Divider()
            
            // Select Time
            VStack {
                Text("Select Time")
                    .font(.headline)
                
                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: [.hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .accentColor(Color(red: 198/225, green: 174/255, blue: 128/255))
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 67/255, green: 13/255, blue: 75/255), lineWidth: 1))
            
            Spacer()
            
            // Done Button
            Button("Done") {
                onDateSelected(selectedDate)
                isSheetPresented = false // Dismiss the sheet
            }
            .padding()
            .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
            .background(Color(red: 67/255, green: 13/255, blue: 75/255))
            .cornerRadius(10)
            .padding()
            .font(.headline)
        }
        .padding()
        .background(Color(red: 250/255, green: 244/255, blue: 250/255))
    }
}

struct DateAndTime_Previews: PreviewProvider {
    static var previews: some View {
        DateAndTime(selectedDate: .constant(Date()), onDateSelected: { _ in }, isSheetPresented: .constant(false))
    }
}
