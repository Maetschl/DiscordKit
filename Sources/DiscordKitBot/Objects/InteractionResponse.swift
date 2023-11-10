//
//  InteractionResponse.swift
//  
//
//  Created by Vincent Kwok on 17/12/22.
//

import Foundation
import DiscordKitCore

// MARK: - Interaction Response
public struct InteractionResponse: Encodable {
    public init(type: InteractionResponse.ResponseType, data: InteractionResponse.ResponseData?) {
        self.type = type
        self.data = data
    }

    public enum ResponseType: Int, Codable {
        case pong = 1
        case interactionReply = 4
        case deferredInteractionReply = 5
        case deferredUpdateMessage = 6
        case updateMessage = 7
        case appCommandAutocompleteResult = 8
        case modal = 9
    }

    public enum ResponseData: Encodable {
        public struct Message: Encodable {
            public init(
                content: String? = nil, tts: String? = nil, embeds: [BotEmbed]? = nil,
                allowed_mentions: AllowedMentions? = nil,
                flags: DiscordKitCore.Message.Flags? = nil,
                components: [Component]? = nil,
                attachments: [NewAttachment]? = nil
            ) {
                self.content = content
                self.tts = tts
                self.embeds = embeds
                self.allowed_mentions = allowed_mentions
                self.flags = flags
                self.components = components
                self.attachments = attachments
            }

            public let content: String?
            public let tts: String?
            public let embeds: [BotEmbed]?
            public let allowed_mentions: AllowedMentions?
            public let flags: DiscordKitCore.Message.Flags?
            public let components: [Component]?
            public let attachments: [NewAttachment]?

            enum CodingKeys: CodingKey {
                case content
                case tts
                case embeds
                case allowed_mentions
                case flags
                case attachments
                case components
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)

                try container.encodeIfPresent(self.content, forKey: .content)
                try container.encodeIfPresent(self.tts, forKey: .tts)
                try container.encodeIfPresent(self.embeds, forKey: .embeds)
                try container.encodeIfPresent(self.allowed_mentions, forKey: .allowed_mentions)
                try container.encodeIfPresent(self.flags, forKey: .flags)
                try container.encodeIfPresent(self.attachments, forKey: .attachments)

                if let components {
                    var componentContainer = container.nestedUnkeyedContainer(forKey: .components)
                    for component in components {
                        try componentContainer.encode(component)
                    }
                }
            }
        }
        
//        public struct Options: Encodable {
//
//            public struct OptionValue: Encodable {
//                public let type: Int
//                public let name: String
//                public let value: String
//                public let focused: Bool
//
//                public init(type: Int, name: String, value: String, focused: Bool) {
//                    self.type = type
//                    self.name = name
//                    self.value = value
//                    self.focused = focused
//                }
//            }
            /*
             {
               "type": 4, //applicationCmdAutocomplete or interactionReply?
               "data": {
                 "id": "816437322781949972",
                 "name": "airhorn",
                 "type": 1,
                 "version": "847194950382780532",
                 "options": [
                   {
                     "type": 3,
                     "name": "variant",
                     "value": "data a user is typ",
                     "focused": true
                   }
                 ]
               }
             }
             */
//            public let id: String
//            public let name: String
//            public let type: Int
//            public let version: String
//            public let options: [OptionValue]
//
//            public init(id: String, name: String, type: Int, version: String, options: [OptionValue]) {
//                self.id = id
//                self.name = name
//                self.type = type
//                self.version = version
//                self.options = options
//            }
//        }
        
        case message(Message)
//        case autocompleteResult(Options)
        // case modal

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()

            switch self {
            case .message(let message): try container.encode(message)
//            case .autocompleteResult(let options): try container.encode(options)
            }
        }
    }

    public let type: ResponseType
    public let data: ResponseData?
}
