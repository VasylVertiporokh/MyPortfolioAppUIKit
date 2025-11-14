// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {
  internal enum Genaral {
    /// Cancel
    internal static let cancel = Localization.tr("Localizable", "genaral.cancel", fallback: "Cancel")
    /// Done
    internal static let done = Localization.tr("Localizable", "genaral.done", fallback: "Done")
    /// Localizable.strings
    ///   MyPortfolioApp
    /// 
    ///   Created by Vasia Vertiporoh on 11/11/2025.
    internal static let error = Localization.tr("Localizable", "genaral.error", fallback: "Error")
    /// OK
    internal static let ok = Localization.tr("Localizable", "genaral.ok", fallback: "OK")
  }
  internal enum Projects {
    internal enum ProjectsList {
      /// Projects
      internal static let navigationTitle = Localization.tr("Localizable", "projects.projectsList.navigationTitle", fallback: "Projects")
    }
  }
  internal enum TabBar {
    internal enum Item {
      /// Projects
      internal static let projects = Localization.tr("Localizable", "tabBar.item.projects", fallback: "Projects")
      /// My stack
      internal static let stack = Localization.tr("Localizable", "tabBar.item.stack", fallback: "My stack")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
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
