import Foundation

enum StreamHealthError: LocalizedError {
    case unsupportedScheme

    var errorDescription: String? {
        switch self {
        case .unsupportedScheme:
            return "URL deve começar com rtsp://, http:// ou https://"
        }
    }
}

struct StreamHealthChecker {
    static func validate(_ url: URL) throws {
        let scheme = url.scheme?.lowercased() ?? ""
        guard ["rtsp", "http", "https"].contains(scheme) else {
            throw StreamHealthError.unsupportedScheme
        }
    }
}
