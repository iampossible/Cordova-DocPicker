
enum DocumentTypes: String {
    case pdf = "pdf"
    case image = "image"
    case all = "all"

    var uti: String {
        switch self {
            case .pdf: return "com.adobe.pdf"
            case .image: return "public.image"
            case .all: return "public.data"
        }
    }
}

@objc(DocumentPicker)
class DocumentPicker : CDVPlugin {
    var commandCallback: String?


    @objc(getFile:)
    func getFile(command: CDVInvokedUrlCommand) {

        var arguments: [DocumentTypes] = []

        command.arguments.forEach({
            if let key =  $0 as? String, let type = DocumentTypes(rawValue: key) {
                arguments.append(type)
            }else if let array = $0 as? [String] {
                array.forEach({
                    if let type = DocumentTypes(rawValue: $0) {
                        arguments.append(type)
                    }
                })
            }

        })

        if arguments.count < 1 {
            sendError("Didn't receive any argument.")
        }else{
            commandCallback = command.callbackId
            callPicker(withTypes: arguments)
        }
    }

    func callPicker(withTypes documentTypes: [DocumentTypes]) {

        let utis = documentTypes.flatMap({return $0.uti })

        let picker = UIDocumentPickerViewController(documentTypes: utis, in: .import)
        picker.delegate = self
        self.viewController.present(picker, animated: true, completion: nil)

    }

    func documentWasSelected(document: URL) {
        if let commandId = commandCallback  {

            let pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: document.absoluteString
            )

            self.commandDelegate!.send(
                pluginResult,
                callbackId: commandId
            )

            commandCallback = nil
        }else{
            sendError("Unexpected error. Try again?")
        }
    }

    func sendError(_ message: String) {

        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR,
            messageAs: message
        )

        self.commandDelegate!.send(
            pluginResult,
            callbackId: commandCallback
        )
    }

}

extension DocumentPicker: UIDocumentPickerDelegate {

    @available(iOS 11.0, *)
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            documentWasSelected(document: url)
        }
    }


    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL){
        documentWasSelected(document: url)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        sendError("User canceled.")
    }

}
