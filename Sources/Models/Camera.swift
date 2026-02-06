import Foundation

struct Camera: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let streamURL: URL
}
