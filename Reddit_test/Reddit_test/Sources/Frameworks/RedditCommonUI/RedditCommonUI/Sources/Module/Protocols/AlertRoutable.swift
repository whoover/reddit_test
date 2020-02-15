import UIKit

public protocol AlertRoutableProtocol: PresentableProtocol {
    typealias AlertTextFieldHandler = (UITextField) -> Void
    
    func showAlert(title: String, message: String)
    func showAllert(config: AlertConfiguration, style: UIAlertController.Style)
    func showAlertWithTextField(configuration: TextFieldAlertConfiguration)
}

public struct TextFieldAlertConfiguration {
    let title: String?
    var message: String?
    var placeholder: String?
    var handler: AlertRoutableProtocol.AlertTextFieldHandler
}

public struct AlertConfiguration {
    typealias AlertCompletion = () -> Void
    typealias AlertActionHandler = (UIAlertAction) -> Void
    
    var title: String?
    var message: String?
    var actions: [UIAlertAction]
    var completion: AlertCompletion?
    
    init(title: String?, message: String?, completion: AlertCompletion? = nil) {
        self.init(title: title, message: message, actions: [], completion: completion)
    }
    
    init(title: String?, message: String?, actions: [UIAlertAction], completion: AlertCompletion? = nil) {
        self.title = title
        self.message = message
        self.actions = actions
        self.completion = completion
    }
    
    mutating func addAction(title: String?, style: UIAlertAction.Style, actionHandler: AlertActionHandler? = nil) {
        self.actions.append(UIAlertAction(title: title, style: style, handler: actionHandler))
    }
}

extension AlertRoutableProtocol {
    public func showAlert(title: String, message: String) {
        guard let source = toPresent() else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let completeAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(completeAction)
        source.present(alertController, animated: true, completion: nil)
        
    }
    
    public func showAlertWithTextField(configuration: TextFieldAlertConfiguration) {
        guard let source = toPresent() else {
            return
        }
        let alertController = UIAlertController(title: configuration.title, message: configuration.message, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = configuration.placeholder
        }
        
        let completeAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alertController] _ -> Void in
            if let textField = alertController?.textFields?.first {
                configuration.handler(textField)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(completeAction)
        alertController.addAction(cancelAction)
        
        source.present(alertController, animated: true, completion: nil)
    }
    
    public func showAllert(config: AlertConfiguration, style: UIAlertController.Style) {
        guard let source = toPresent() else {
            return
        }
        let alertController = UIAlertController(title: config.title, message: config.message, preferredStyle: style)
        config.actions.forEach {
            alertController.addAction($0)
        }
        
        source.present(alertController, animated: true, completion: config.completion)
    }
}
