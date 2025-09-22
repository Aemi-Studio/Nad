import SafariServices
import SwiftUI

@Observable
@MainActor
final class BlockerState: Animatable {
    #if os(iOS)
    private let identifier: String = "studio.aemi.Nad.iOSBlocker"
    #elseif os(macOS)
    private let identifier: String = "studio.aemi.Nad.macOSBlocker"
    #endif

    private(set) var state = State.unknown {
        didSet {
            #if os(iOS)
            Task { @MainActor in
                if state.boolean {
                    Tools.setAlternateIconName("AppIcon2")
                } else {
                    Tools.setAlternateIconName("AppIcon3")
                }
            }
            #endif
        }
    }

    private var notification: NSObjectProtocol?

    init() {
        let notificationName: NSNotification.Name

        #if os(macOS)
        notificationName = NSWindow.didBecomeMainNotification
        #else
        notificationName = UIApplication.didBecomeActiveNotification
        #endif

        notification = NotificationCenter.default
            .addObserver(forName: notificationName, object: nil, queue: .main) { [weak self] _ in
                Task { @MainActor [weak self] in
                    self?.refresh()
                }
            }

        refresh()
    }

    deinit {
        Task { @MainActor [weak self] in
            if let observer = self?.notification {
                NotificationCenter.default.removeObserver(observer)
            }
        }
    }

    func refresh() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let state = try await SFContentBlockerManager.stateOfContentBlocker(withIdentifier: identifier)
                withAnimation(.smooth) {
                    self.state = state.isEnabled ? .enabled : .disabled
                }
            } catch {
                withAnimation(.smooth) {
                    state = .error(error)
                }
            }
        }
    }

    enum State: Equatable, Sendable, CustomStringConvertible {
        case enabled
        case disabled
        case unknown
        case error(Error)

        var boolean: Bool {
            self == .enabled
        }

        var description: String {
            switch self {
            case .enabled:
                String(localized: "blockerState.enabled")
            case .disabled:
                String(localized: "blockerState.disabled")
            case .unknown:
                String(localized: "blockerState.unknown")
            case .error:
                String(localized: "blockerState.error")
            }
        }

        var color: Color {
            switch self {
            case .enabled:
                .green
            case .disabled:
                .red
            case .unknown:
                .gray
            case .error:
                .orange
            }
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.enabled, .enabled), (.disabled, .disabled), (.unknown, .unknown):
                true
            case let (.error(lError), .error(rError)):
                (lError as NSError).domain == (rError as NSError).domain
                    && (lError as NSError).code == (rError as NSError).code
            default:
                false
            }
        }
    }
}
