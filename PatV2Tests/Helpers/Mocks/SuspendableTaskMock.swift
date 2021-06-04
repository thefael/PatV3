@testable import PatV2

class SuspendableTaskMock: SuspendableTask {
    var didCallSuspend = false

    func suspend() {
        didCallSuspend = true
    }
}
