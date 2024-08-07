//
//  ContentView.swift
//  ToDO Application
//
//  Created by Parth Kumar on 7/29/24.
//

import SwiftUI

//
//  ContentView.swift
//  ToDo List
//
//  Created by Parth Kumar on 7/29/24.
//
struct ContentView: View {
    @State private var currentTodo = ""
    @State private var todos: [Item] = []
    @State private var selectedDate = Date()
    private func save() {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(self.todos), forKey: "myTodosKey")
    }
    private func load() {
        if let todosData = UserDefaults.standard.value(forKey: "myTodosKey") as? Data {
            if let todosList
                = try? PropertyListDecoder().decode(Array<Item>.self,from:todosData) {
                self.todos = todosList
            }
        }
    }
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    private func delete(at offset: IndexSet) {
        self.todos.remove(atOffsets: offset)
        save()
    }
    var body: some View {
        NavigationView {
            VStack {
                    TextField("New todo..", text: $currentTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                    Spacer()
                    DatePicker("Select date and time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                    
                    Button(action: {
                        guard !self.currentTodo.isEmpty else { return }
                        self.todos.append(Item(todo: self.currentTodo, dateCreated: selectedDate))
                        self.currentTodo = ""
                        self.save()
                    }) {
                        Image(systemName: "text.badge.plus")
                    }

                    .padding(.leading, 5)
                .padding()
                List {
                    ForEach(todos) { todoEntry in
                            Text(todoEntry.todo)
                            Text("\(todoEntry.dateCreated, formatter: dateFormatter)")
                    }
                    .onDelete(perform: delete)
                }
            }

            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Todo List")
                        .font(.headline)
                }
            }
        }.onAppear(perform: load)
    }
    
    struct ContentView_Previews:
        PreviewProvider {
        static var previews: some
        View {
            ContentView()
        }
    }
}
