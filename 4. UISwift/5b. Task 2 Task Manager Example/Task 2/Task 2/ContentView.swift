//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Bednarz on 14/08/2025.
//

import SwiftUI

final class TaskManager: ObservableObject {
    @Published var tasks: [String] = ["Task 1", "Task 2"]
}

struct ContentView: View {
    @ObservedObject private var taskManager = TaskManager()
    
    var body: some View {
        VStack {
            TaskListView()
            AddTaskView()
            RemoveTaskView()
        }
        .environmentObject(taskManager)
        .padding()
    }
}

struct TaskListView: View {
    @EnvironmentObject private var taskManager: TaskManager
    
    var body: some View {
        List {
            ForEach(taskManager.tasks, id: \.self){
                Text($0)
            }
        }
    }
}


struct AddTaskView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var taskToSubmit: String = ""
    
    var body: some View {
        Form {
            TextField(text: $taskToSubmit, prompt: Text("Enter task name")) {}
            Button("Add task") {
                if !taskToSubmit.isEmpty {
                    taskManager.tasks.append(taskToSubmit)
                    taskToSubmit = ""
                }
            }
            .disabled(taskToSubmit.isEmpty)
        }
    }
}

struct RemoveTaskView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var taskToDelete: String = ""
    
    var body: some View {
        Form {
            TextField(text: $taskToDelete, prompt: Text("Enter task index")) {}
                .keyboardType(.numberPad)
            Button("Remove") {
                if let index = Int(taskToDelete), index >= 0, index < taskManager.tasks.count {
                    taskManager.tasks.remove(at: index)
                    taskToDelete = ""
                }
            }
            .disabled(taskToDelete.isEmpty || Int(taskToDelete) == nil || Int(taskToDelete)! >= taskManager.tasks.count)
        }
    }
}

#Preview {
    ContentView()
}
