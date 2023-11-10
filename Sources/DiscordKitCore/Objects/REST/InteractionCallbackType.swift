//
//  InteractionCallbackType.swift
//  
//
//  Created by Julian Arias Maetschl on 23-07-23.
//  Definition from https://discord.com/developers/docs/interactions/receiving-and-responding

import Foundation

public enum InteractionCallbackType: Int, Codable {
    case pong = 1 /// ACK a Ping
    case channelMessageWithSource = 4 /// Respond to an interaction with a message
    case deferredChannelMessageWithSource = 5 /// ACK an interaction and edit a response later, the user sees a loading state
    case deferredUpdateMessage = 6 /// For components, ACK an interaction and edit the original message later; the user does not see a loading state
    case updateMessage = 7 /// For components, edit the message the component was attached to
    case applicationCommandAutocompleteResult = 8 /// Respond to an autocomplete interaction with suggested choices
    case modal = 9 /// Respond to an interaction with a popup modal
}
