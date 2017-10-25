@objc(DocumentPicker) class DocumentPicker : CDVPlugin {
   weak var command: CDVInvokedUrlCommand?

  @objc(getFile:)
  func getFile(command: CDVInvokedUrlCommand) {

    let msg = command.arguments[0] as? String ?? ""

    if msg.count > 0 {

        self.command = command
        callPicker()

    }else{

        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }

  }

    func callPicker() {
        if let url = URL(string: "public.image") {
            let picker = UIDocumentPickerViewController(url:url, in: UIDocumentPickerMode.open)
            picker.delegate = self
            self.viewController.present(picker, animated: true, completion: nil)
        }
    }

}
extension DocumentPicker: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        if let first = urls.first, let command = command  {
            let pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: first.absoluteString
            )

            self.commandDelegate!.send(
                pluginResult,
                callbackId: command.callbackId
            )

            self.command = nil
        }
    }
}
