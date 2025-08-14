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



//
//What should be done
//*
//Important Note
//
//Scope Limitation:
//Tasks in this example are stored in memory only.
//They will not persist between app sessions.
//Avoid implementing persistence mechanisms such as Core Data, UserDefaults, or JSON file storage.
//This restriction simplifies the task to focus on state management within the view hierarchy using @EnvironmentObject.
//﻿
//
//Define a TaskManagerclass:
//Conforms to ObservableObjectand contains a @Publishedarray of tasks ([String]).
//Create a Root View:
//Injects the TaskManagerobject into the environment.
//Build Three Views:
//TaskListView: Displays the list of tasks.
//AddTaskView: Provides a text field and button to add tasks to the list.
//RemoveTaskView: Provides functionality to remove a task by its index.
//Use @EnvironmentObject:
//Access the shared list of tasks within these views for seamless task management.
