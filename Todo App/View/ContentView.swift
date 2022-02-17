//
//  ContentView.swift
//  Todo App
//
//  Created by Arthur Neves on 09/02/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @State private var showingAddTodoView: Bool = false
  
  var body: some View {
    NavigationView {
      List(0 ..< 5) { item in
        Text("Select an item")
      } //: List
      .navigationBarTitle("Todo", displayMode: .inline)
      .navigationBarItems(trailing:
                            Button {
        self.showingAddTodoView.toggle()
      } label: {
        Image(systemName: "plus")
      }
                            .sheet(isPresented: $showingAddTodoView) {
        AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
      }
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
