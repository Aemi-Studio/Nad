import SafariServices

@Observable
final class BlockerState {

    #if os(iOS)
    private let identifier: String = "studio.aemi.Nad.iOSBlocker"
    #elseif os(macOS)
    private let identifier: String = "studio.aemi.Nad.macOSBlocker"
    #endif

    private var state: Result<Bool, Error>?

    private var notification: NSObjectProtocol?

    init() {

        let notificationName: NSNotification.Name

        #if os(macOS)
        notificationName = NSWindow.didBecomeMainNotification
        #else
        notificationName = UIApplication.didBecomeActiveNotification
        #endif

        notification = NotificationCenter.default.addObserver(
            forName: notificationName,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.refresh()
        }

        self.refresh()
    }

    deinit {
        if let observer = self.notification {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    /// A Boolean value that indicates whether the content blocker is enabled.
    var isEnabled: Bool {
        switch state {
        case let .success(isEnabled):
            isEnabled
        case .failure, nil:
            false
        }
    }

    func refresh() {
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: identifier) { state, error in
            DispatchQueue.main.async {
                if let state = state {
                    self.state = .success(state.isEnabled)
                } else if let error = error {
                    self.state = .failure(error)
                } else {
                    self.state = nil
                }
            }
        }
    }
}
