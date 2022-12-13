//
//  CmdOption.swift
//  
//
//  Created by Vincent Kwok on 12/12/22.
//

import Foundation
import DiscordKitCore

/// An option in an application command
public protocol CommandOption: Codable {
    /// The type of this option
    var type: CommandOptionType { get }

    /// Name of this command
    ///
    /// > Important: Must be 1-32 characters long, matching the following Regex: `^[-_\p{L}\p{N}\p{sc=Deva}\p{sc=Thai}]{1,32}$`
    var name: String { get }

    /// Description of this command
    ///
    /// > Important: Must be 1-100 characters long
    var description: String { get }
    /// If this command is required
    var required: Bool? { get }

    // If this command is a subcommand or subcommand group type, these nested options will be its parameters
    // var options: [CommandOption]? { get }

    /// Channel types to restrict visibility of command to
    // var channel_types: ChannelType? { get }
}

public struct AppCommandOptionChoice: Codable {
    public let name: String
    public let value: Interaction.Data.AppCommandData.OptionData.Value // Trust me it makes more sense nested like this
}

/// An enum to store either a `Double` or `Int` value for setting the minimum or maximum value of an option
enum MinMaxValue: Codable {
    /// Min or max value for an option of ``CommandOptionType/number`` type
    case number(Double)
    /// Min or max value for an option of ``CommandOptionType/integer`` type
    case integer(Int)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let val = try? container.decode(Double.self) {
            self = .number(val)
        } else if let val = try? container.decode(Int.self) {
            self = .integer(val)
        } else {
            throw DecodingError.typeMismatch(
                Int.self,
                .init(codingPath: [], debugDescription: "Expected either Int or Double, found neither")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .number(let value): try container.encode(value)
        case .integer(let value): try container.encode(value)
        }
    }
}
