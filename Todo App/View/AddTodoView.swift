//
//  AddTodoView.swift
//  Todo App
//
//  Created by Arthur Neves on 09/02/22.
//

import SwiftUI

struct AddTodoView: View {
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @State private var name: String = ""
  @State private var priority: String = "Normal"
  
  let priorities = ["High", "Normal", "Low"]
  
    var body: some View {
      NavigationView {
        VStack {
          Form {
            TextField("Todo", text: $name)
            
            Picker("Priority", selection: $priority) {
              ForEach(priorities, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // MARK: - SAVE BUTTON
            Button {
              if self.name != "" {
                let todo = Todo(context: self.managedObjectContext)
                todo.name = self.name
                todo.priority = self.priority
                
                do {
                  try self.managedObjectContext.save()
                  print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                } catch {
                  print(error)
                }
              }
            } label: {
              Text("Save")
            }
          } //: Form
          
          Spacer()
          
        } //: VStack
        .navigationBarTitle("New Todo", displayMode: .inline)
        .navigationBarItems(trailing:
          Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
          Image(systemName: "xmark")
        })
    } //: NavigationView
  }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
