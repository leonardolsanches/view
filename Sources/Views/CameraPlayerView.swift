import AVKit
import SwiftUI

struct CameraPlayerView: View {
    let camera: Camera

    var body: some View {
        VideoPlayer(player: AVPlayer(url: camera.streamURL))
            .navigationTitle(camera.name)
            .ignoresSafeArea()
    }
}
