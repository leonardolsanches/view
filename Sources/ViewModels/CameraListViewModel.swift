import Foundation
import SwiftUI

@MainActor
final class CameraListViewModel: ObservableObject {
    @Published var cameras: [Camera] = [
        Camera(
            name: "Portão",
            streamURL: URL(string: "rtsp://usuario:senha@192.168.1.120:554/stream1")!
        ),
        Camera(
            name: "Garagem",
            streamURL: URL(string: "https://exemplo.local/camera/garage.m3u8")!
        )
    ]

    func validate(camera: Camera) -> String? {
        do {
            try StreamHealthChecker.validate(camera.streamURL)
            return nil
        } catch {
            return error.localizedDescription
        }
    }
}
