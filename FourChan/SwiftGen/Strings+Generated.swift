// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  /// Anime & Mange
  internal static let animeMange = S.tr("Localizable", "animeMange", fallback: "Anime & Mange")
  /// Cancel
  internal static let cancelButton = S.tr("Localizable", "cancelButton", fallback: "Cancel")
  /// Localizable.strings
  ///   FourChan
  /// 
  ///   Created by Yeldos Marat on 20.06.2023.
  internal static let chooseBoard = S.tr("Localizable", "chooseBoard", fallback: "Choose board")
  /// Fit
  internal static let fit = S.tr("Localizable", "fit", fallback: "Fit")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
