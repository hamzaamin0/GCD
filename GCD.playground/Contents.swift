import UIKit

//MARK: Dispatch Work Item

let queue = DispatchQueue(label: "com.test.dispatch.workitem")

let item = DispatchWorkItem {
    
    print("work started")
}

queue.async(execute: item)

queue.asyncAfter(deadline: .now() + 1.0, execute: item)

item.cancel()

if item.isCancelled {
    
    print("task was cancelled")
    
}

//MARK: synchronus

let syncQueue = DispatchQueue(label: "com.test.dispatch.sync")
syncQueue.sync {
    print("sync queue")
}
print("after sync")


//MARK: asynchronous

let asyncQueue = DispatchQueue(label: "com.test.dispatch.sync")
asyncQueue.async {
    Thread.sleep(forTimeInterval: 2)
    print("async queue")
}
print("after async")


//MARK:Dispatch Group

let group = DispatchGroup()

let date = Date()

let queue1 = DispatchQueue(label: "com.test.dispatch.group", attributes: .concurrent)

queue1.async(group: group) {
    
    Thread.sleep(forTimeInterval: 3)
    let difference = Date().timeIntervalSince(date)
    print("Task 1 completed with \(difference) time difference")
    
}

let queue2 = DispatchQueue(label: "com.test.dispatch.groupp")
queue2.async(group: group) {
    Thread.sleep(forTimeInterval: 1)
    let difference = Date().timeIntervalSince(date)
    print("Task 2 completed with \(difference) time difference")
}

group.notify(queue: DispatchQueue.main) {
    
    Thread.sleep(forTimeInterval: 1)
    let difference = Date().timeIntervalSince(date)
    print("All tasks completed with \(difference) time interval")
    
}

//MARK:Thread Explosion

let explodedThread = DispatchQueue(label: "com.test.dispatch.explode", attributes: .concurrent)

//for i in 0 ... 100000 {
//
//    explodedThread.async {
//        Thread.sleep(forTimeInterval: 1)
//        print("Executed Task \(i)")
//    }
//}
//
//DispatchQueue.main.async {
//    print("All Tasks Completed")
//}

//MARK: Semaphore

let concurrentTasks = 4

let semaPhore = DispatchSemaphore(value: concurrentTasks)

for j in 0 ... 1000{
    explodedThread.async {
        Thread.sleep(forTimeInterval: 1)
        print("Executed Task \(j)")
        semaPhore.signal()
    }
    semaPhore.wait()
    
}

DispatchQueue.main.async {
    print("All Tasks Completed")
}
