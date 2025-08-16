//
//  MessageComposerViewController.swift
//  union-share
//
//  Created by Ben Sage on 7/19/25.
//

import SwiftUI
import MessageUI

struct MessageComposerViewController: UIViewControllerRepresentable {
    let recipients: [String]
    let body: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        let parent: MessageComposerViewController
        
        init(_ parent: MessageComposerViewController) {
            self.parent = parent
        }
        
        func messageComposeViewController(
            _ controller: MFMessageComposeViewController,
            didFinishWith result: MessageComposeResult
        ) {
            Task { @MainActor in
                 controller.dismiss(animated: true)
            }
        }
    }
}
