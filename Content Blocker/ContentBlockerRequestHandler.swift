import Foundation
import UniformTypeIdentifiers

final class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {

        let attachment = NSItemProvider(
            contentsOf: Bundle.main.url(
                forResource: "eo+general",
                withExtension: "json"
            )
        )!

        let item = NSExtensionItem()
        item.attachments = [attachment]

        context.completeRequest(returningItems: [item], completionHandler: nil)
    }

}
