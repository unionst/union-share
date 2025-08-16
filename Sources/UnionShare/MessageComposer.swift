//
//  MessageComposer.swift
//  union-share
//
//  Created by Aaron Moss on 7/19/25.
//

import SwiftUI
import MessageUI

struct MessageComposer: ViewModifier {
    @Binding var isPresented: Bool
    let body: String
    let recipients: [String]
    
    private var shouldShowAlert: Binding<Bool> {
        Binding(
            get: { isPresented && !MFMessageComposeViewController.canSendText() },
            set: { isPresented = $0 }
        )
    }
    
    private var shouldShowSheet: Binding<Bool> {
        Binding(
            get: { isPresented && MFMessageComposeViewController.canSendText() },
            set: { isPresented = $0 }
        )
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: shouldShowSheet) {
                MessageComposerViewController(
                    recipients: recipients,
                    body: body
                )
            }
            .alert("Not Available", isPresented: shouldShowAlert) {
                Button("OK") { }
            } message: {
                Text("Your device is not able to send text messages.")
            }
    }
}

extension View {
    public func messageComposer(
        isPresented: Binding<Bool>,
        recipients: [String] = [],
        body: String = ""
    ) -> some View {
        modifier(MessageComposer(isPresented: isPresented, body: body, recipients: recipients))
    }
}
