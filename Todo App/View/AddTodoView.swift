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
  
  @State private var errorShowing = false
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  
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
              } else {
                self.errorShowing = true
                self.errorTitle = "Invalida Name"
                self.errorMessage = "Enter a valid text\nfor the new todo item."
                return
              }
              self.presentationMode.wrappedValue.dismiss()
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
        .alert(isPresented: $errorShowing) {
          Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
        }
    } //: NavigationView
  }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
