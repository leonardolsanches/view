import SwiftUI

struct CameraListView: View {
    @StateObject private var viewModel = CameraListViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.cameras) { camera in
                NavigationLink(destination: CameraPlayerView(camera: camera)) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(camera.name)
                            .font(.headline)

                        Text(camera.streamURL.absoluteString)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)

                        if let message = viewModel.validate(camera: camera) {
                            Text(message)
                                .font(.caption2)
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Câmeras")
        }
    }
}
