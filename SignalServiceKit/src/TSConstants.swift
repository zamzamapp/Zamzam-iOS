//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

private protocol TSConstantsProtocol: class {
    var textSecureWebSocketAPI: String { get }
    var textSecureServerURL: String { get }
    var textSecureCDN0ServerURL: String { get }
    var textSecureCDN2ServerURL: String { get }
    var contactDiscoveryURL: String { get }
    var keyBackupURL: String { get }
    var storageServiceURL: String { get }
    var kUDTrustRoot: String { get }

    var censorshipReflectorHost: String { get }

    var serviceCensorshipPrefix: String { get }
    var cdn0CensorshipPrefix: String { get }
    var cdn2CensorshipPrefix: String { get }
    var contactDiscoveryCensorshipPrefix: String { get }
    var keyBackupCensorshipPrefix: String { get }
    var storageServiceCensorshipPrefix: String { get }

    var contactDiscoveryEnclaveName: String { get }
    var contactDiscoveryMrEnclave: String { get }

    var keyBackupEnclaveName: String { get }
    var keyBackupMrEnclave: String { get }
    var keyBackupServiceId: String { get }

    var applicationGroup: String { get }

    var serverPublicParamsBase64: String { get }
}

// MARK: -

@objc
public class TSConstants: NSObject {

    @objc
    public static let EnvironmentDidChange = Notification.Name("EnvironmentDidChange")

    // Never instantiate this class.
    private override init() {}

    @objc
    public static var textSecureWebSocketAPI: String { return shared.textSecureWebSocketAPI }
    @objc
    public static var textSecureServerURL: String { return shared.textSecureServerURL }
    @objc
    public static var textSecureCDN0ServerURL: String { return shared.textSecureCDN0ServerURL }
    @objc
    public static var textSecureCDN2ServerURL: String { return shared.textSecureCDN2ServerURL }
    @objc
    public static var contactDiscoveryURL: String { return shared.contactDiscoveryURL }
    @objc
    public static var keyBackupURL: String { return shared.keyBackupURL }
    @objc
    public static var storageServiceURL: String { return shared.storageServiceURL }
    @objc
    public static var kUDTrustRoot: String { return shared.kUDTrustRoot }

    @objc
    public static var censorshipReflectorHost: String { return shared.censorshipReflectorHost }

    @objc
    public static var serviceCensorshipPrefix: String { return shared.serviceCensorshipPrefix }
    @objc
    public static var cdn0CensorshipPrefix: String { return shared.cdn0CensorshipPrefix }
    @objc
    public static var cdn2CensorshipPrefix: String { return shared.cdn2CensorshipPrefix }
    @objc
    public static var contactDiscoveryCensorshipPrefix: String { return shared.contactDiscoveryCensorshipPrefix }
    @objc
    public static var keyBackupCensorshipPrefix: String { return shared.keyBackupCensorshipPrefix }
    @objc
    public static var storageServiceCensorshipPrefix: String { return shared.storageServiceCensorshipPrefix }

    @objc
    public static var contactDiscoveryEnclaveName: String { return shared.contactDiscoveryEnclaveName }
    @objc
    public static var contactDiscoveryMrEnclave: String { return shared.contactDiscoveryMrEnclave }

    @objc
    public static var keyBackupEnclaveName: String { return shared.keyBackupEnclaveName }
    @objc
    public static var keyBackupMrEnclave: String { return shared.keyBackupMrEnclave }
    @objc
    public static var keyBackupServiceId: String { return shared.keyBackupServiceId }

    @objc
    public static var applicationGroup: String { return shared.applicationGroup }

    @objc
    public static var serverPublicParamsBase64: String { return shared.serverPublicParamsBase64 }

    @objc
    public static var isUsingProductionService: Bool {
        return environment == .production
    }

    private enum Environment {
        case production, staging
    }

    private static let serialQueue = DispatchQueue(label: "TSConstants")
    private static var _forceEnvironment: Environment?
    private static var forceEnvironment: Environment? {
        get {
            return serialQueue.sync {
                return _forceEnvironment
            }
        }
        set {
            serialQueue.sync {
                _forceEnvironment = newValue
            }
        }
    }

    private static var environment: Environment {
        if let environment = forceEnvironment {
            return environment
        }
        return FeatureFlags.isUsingProductionService ? .production : .staging
    }

    @objc
    public class func forceStaging() {
        forceEnvironment = .staging
    }

    @objc
    public class func forceProduction() {
        forceEnvironment = .production
    }

    private static var shared: TSConstantsProtocol {
        switch environment {
        case .production:
            return TSConstantsProduction()
        case .staging:
            return TSConstantsStaging()
        }
    }
}

// MARK: -

private class TSConstantsProduction: TSConstantsProtocol {

    public let textSecureWebSocketAPI = "wss://signal.zamzam.chat/v1/websocket/"
    public let textSecureServerURL = "https://signal.zamzam.chat/"
    public let textSecureCDN0ServerURL = "https://cdn.zamzam.chat"
    public let textSecureCDN2ServerURL = "https://cdn.zamzam.chat"
    public let contactDiscoveryURL = "https://signal.zamzam.chat"
    public let keyBackupURL = "https://signal.zamzam.chat"
    public let storageServiceURL = "https://signal.zamzam.chat"
    public let kUDTrustRoot = "BVfyxGL4xJMq3D689G9cWV4w8WnqRuMzUtO0fTHEeAla"

    public let censorshipReflectorHost = "europe-west1-signal-cdn-reflector.cloudfunctions.net"

    public let serviceCensorshipPrefix = "service"
    public let cdn0CensorshipPrefix = "cdn"
    public let cdn2CensorshipPrefix = "cdn2"
    public let contactDiscoveryCensorshipPrefix = "directory"
    public let keyBackupCensorshipPrefix = "backup"
    public let storageServiceCensorshipPrefix = "storage"

    public let contactDiscoveryEnclaveName = "cd6cfc342937b23b1bdd3bbf9721aa5615ac9ff50a75c5527d441cd3276826c9"
    public var contactDiscoveryMrEnclave: String {
        return contactDiscoveryEnclaveName
    }

    public let keyBackupEnclaveName = "fe7c1bfae98f9b073d220366ea31163ee82f6d04bead774f71ca8e5c40847bfe"
    public let keyBackupMrEnclave = "a3baab19ef6ce6f34ab9ebb25ba722725ae44a8872dc0ff08ad6d83a9489de87"
    public var keyBackupServiceId: String {
        return keyBackupEnclaveName
    }

    public let applicationGroup = "group.org.whispersystems.signal.group"

    // We need to discard all profile key credentials if these values ever change.
    // See: GroupsV2Impl.verifyServerPublicParams(...)
    public let serverPublicParamsBase64 = "AH6+rGx5BLXlV+ynjexd+nykOAPaxcTTu9Doe2yaINIBgC5kXzJoEQUv7OTk0d7tFzjUlHZ9NENcXxZZrgkMRiRuGpc9L8IggvffQO55I+xwionGOwJ2SU/WL8t4wymBXn4XJ2Od08q3L7lA8jG1KYEWkhM4pV6M1T+a9Ulb/ooFMpBhDif0kDciUFuPRfu3HIbwUIkxl2E3agewdxnSgws="
}

// MARK: -

private class TSConstantsStaging: TSConstantsProtocol {

    public let textSecureWebSocketAPI = "wss://signal.zamzam.chat/v1/websocket/"
    public let textSecureServerURL = "https://signal.zamzam.chat/"
    public let textSecureCDN0ServerURL = "https://cdn.zamzam.chat"
    public let textSecureCDN2ServerURL = "https://cdn.zamzam.chat"
    public let contactDiscoveryURL = "https://signal.zamzam.chat"
    public let keyBackupURL = "https://signal.zamzam.chat"
    public let storageServiceURL = "https://signal.zamzam.chat"
    public let kUDTrustRoot = "BVfyxGL4xJMq3D689G9cWV4w8WnqRuMzUtO0fTHEeAla"

    public let censorshipReflectorHost = "europe-west1-signal-cdn-reflector.cloudfunctions.net"

    public let serviceCensorshipPrefix = "service-staging"
    public let cdn0CensorshipPrefix = "cdn-staging"
    public let cdn2CensorshipPrefix = "cdn2-staging"
    public let contactDiscoveryCensorshipPrefix = "directory-staging"
    public let keyBackupCensorshipPrefix = "backup-staging"
    public let storageServiceCensorshipPrefix = "storage-staging"

    // CDS uses the same EnclaveName and MrEnclave
    public let contactDiscoveryEnclaveName = "b657cad56d518827b0938949bb1e5727a9a4db358dd6a88e55e710a89ffa50bd"
    public var contactDiscoveryMrEnclave: String {
        return contactDiscoveryEnclaveName
    }

    public let keyBackupEnclaveName = "823a3b2c037ff0cbe305cc48928cfcc97c9ed4a8ca6d49af6f7d6981fb60a4e9"
    public let keyBackupMrEnclave = "a3baab19ef6ce6f34ab9ebb25ba722725ae44a8872dc0ff08ad6d83a9489de87"
    public var keyBackupServiceId: String {
        return keyBackupEnclaveName
    }

    public let applicationGroup = "group.org.whispersystems.signal.group.staging"

    // We need to discard all profile key credentials if these values ever change.
    // See: GroupsV2Impl.verifyServerPublicParams(...)
    public let serverPublicParamsBase64 = "AH6+rGx5BLXlV+ynjexd+nykOAPaxcTTu9Doe2yaINIBgC5kXzJoEQUv7OTk0d7tFzjUlHZ9NENcXxZZrgkMRiRuGpc9L8IggvffQO55I+xwionGOwJ2SU/WL8t4wymBXn4XJ2Od08q3L7lA8jG1KYEWkhM4pV6M1T+a9Ulb/ooFMpBhDif0kDciUFuPRfu3HIbwUIkxl2E3agewdxnSgws="
}
