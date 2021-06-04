import Foundation

protocol SuspendableTask {
    func suspend()
}

struct DataTaskSuspendable: SuspendableTask {
    let task: URLSessionTask

    func suspend() {
        task.suspend()
    }
}
