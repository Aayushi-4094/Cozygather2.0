import SwiftUI

struct taskview: View {
    
    @State private var presentTask = false
    @State private var showDate = false
    @State private var showTime = false
    @State private var showAlert = false
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selectedSegment, label: Text("")) {
                    Text("All").tag(0)
                    Text("Completed").tag(1)
                    Text("Incomplete").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    
                    TaskView()
                    TaskView()
                    
                        .navigationTitle("Your tasks")
                        .navigationBarItems(trailing: Button {
                            presentTask.toggle()
                        } label: {
                            Image(systemName: "plus")
                        })
                        .sheet(isPresented: $presentTask) {
                            NavigationView {
                                Form {
                                    Section(header: Text("Task Details")) {
                                        TextField("Title", text: $newTaskTitle)
                                        TextField("Description", text: $newTaskDescription)
                                    }
                                    
                                    Section(header: Text("Due Date")) {
                                        Toggle(isOn: $showDate) {
                                            Text("Include Date")
                                        }
                                        if showDate {
                                            DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                                        }
                                    }
                                    
                                    Section(header: Text("Due Date and Time")) {
                                        Toggle(isOn: $showTime) {
                                            Text("Include Time")
                                        }
                                        if showTime {
                                            DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                        }
                                    }
                                }
                                .navigationBarTitle("Add Task", displayMode: .inline)
                                .navigationBarItems(trailing: Button(action: {
                                    if newTaskTitle.isEmpty {
                                        showAlert = true
                                    } else {
                                        // Add task logic goes here
                                        presentTask.toggle()
                                        newTaskTitle = ""
                                        newTaskDescription = ""
                                        selectedDate = Date()
                                        selectedTime = Date()
                                    }
                                }) {
                                    Text("Add")
                                })
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("Error"), message: Text("Add Title for your task"))
                                }
                            }
                            .presentationDetents([.medium])
                        }
                }
            }
        }
    }
}

struct TaskView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 1)
            Text("Untitled Task")
                .font(.headline)
            
            Spacer(minLength: 1)
            
            Text("No description")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer(minLength: 1)
            }
        }
    }

struct taskview_Previews: PreviewProvider {
    static var previews: some View {
        taskview()
    }
}
