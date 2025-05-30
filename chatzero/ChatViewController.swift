//
//  ChatViewController.swift
//  chatzero
//
//  Created by Hector Steven Villasano on 5/30/25.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var currentUser = Sender(senderId: "self", displayName: "me")
    var aisender = Sender(senderId: "id2", displayName: "gemini")
    var messages = [MessageType]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        messages.append(Message(sender: currentSender,
                                messageId: UUID().uuidString,
                                sentDate: Date().addingTimeInterval(-26400),
                                kind: .text("ok")))
        messages.append(Message(sender: aisender,
                                messageId:  UUID().uuidString,
                                sentDate: Date().addingTimeInterval(-26430),
                                kind: .text("what?")))
        messages.append(Message(sender: currentSender,
                                messageId:  UUID().uuidString,
                                sentDate: Date().addingTimeInterval(-26300),
                                kind: .text("Why are you here")))
        messages.append(Message(sender: aisender,
                                messageId: UUID().uuidString,
                                sentDate: Date().addingTimeInterval(-26330),
                                kind: .text("Because i am ai?")))
        
        
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        // !! Reload collection view to dsiplay data
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(animated: false)
    }
    

    var currentSender: SenderType {
        return currentUser
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }

}
