diff --git a/AppleTVIPCamPlayer/App/PlayerViewModel.swift b/AppleTVIPCamPlayer/App/PlayerViewModel.swift
new file mode 100644
index 0000000000000000000000000000000000000000..7484a5feae7b3fc4fd552b4584afb3ce477b7cce
--- /dev/null
+++ b/AppleTVIPCamPlayer/App/PlayerViewModel.swift
@@ -0,0 +1,123 @@
+import AVFoundation
+import Combine
+import Foundation
+
+final class PlayerViewModel: ObservableObject {
+    @Published var scheme: String = "rtsp"
+    @Published var cameraHost: String = "192.168.0.3"
+    @Published var cameraPort: String = "554"
+    @Published var streamPath: String = "/11"
+    @Published var customURL: String = ""
+
+    @Published var username: String = "leonardo"
+    @Published var password: String = "Theo@2011"
+
+    @Published var statusMessage: String = "Configuração carregada. Valide a URL RTSP e pressione Reproduzir."
+    @Published var isPlaying: Bool = false
+
+    let player = AVPlayer()
+
+    private var cancellables = Set<AnyCancellable>()
+
+    init() {
+        observePlayerStatus()
+    }
+
+    var generatedURL: String {
+        let normalizedPath = streamPath.hasPrefix("/") ? streamPath : "/\(streamPath)"
+        return "\(scheme)://\(cameraHost):\(cameraPort)\(normalizedPath)"
+    }
+
+    var netipHint: String {
+        "Porta NETIP (34567) é para integração VMS/ICSee e não para AVPlayer direto. Use RTSP/HLS na Apple TV."
+    }
+
+    func applyProvidedCameraConfig() {
+        cameraHost = "192.168.0.3"
+        cameraPort = "554"
+        streamPath = "/11"
+        username = "leonardo"
+        password = "Theo@2011"
+        scheme = "rtsp"
+        statusMessage = "Preset aplicado (IP 192.168.0.3). Se não abrir, teste /12 ou porta 8554."
+    }
+
+    func play() {
+        guard let url = buildURL() else {
+            statusMessage = "URL inválida. Exemplo: rtsp://192.168.0.3:554/11"
+            isPlaying = false
+            return
+        }
+
+        player.replaceCurrentItem(with: AVPlayerItem(url: url))
+        player.play()
+
+        statusMessage = "Conectando em \(url.host ?? "câmera")..."
+        isPlaying = true
+    }
+
+    func stop() {
+        player.pause()
+        player.replaceCurrentItem(with: nil)
+        statusMessage = "Reprodução parada."
+        isPlaying = false
+    }
+
+    func retry() {
+        stop()
+        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
+            self.play()
+        }
+    }
+
+    private func buildURL() -> URL? {
+        let base = customURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
+            ? generatedURL
+            : customURL.trimmingCharacters(in: .whitespacesAndNewlines)
+
+        guard var components = URLComponents(string: base),
+              let selectedScheme = components.scheme?.lowercased(),
+              ["rtsp", "http", "https"].contains(selectedScheme) else {
+            return nil
+        }
+
+        if !username.isEmpty {
+            components.user = username
+        }
+
+        if !password.isEmpty {
+            components.password = password
+        }
+
+        return components.url
+    }
+
+    private func observePlayerStatus() {
+        player.publisher(for: \.timeControlStatus)
+            .receive(on: DispatchQueue.main)
+            .sink { [weak self] status in
+                guard let self else { return }
+                switch status {
+                case .playing:
+                    self.statusMessage = "Transmitindo ao vivo."
+                case .paused:
+                    if self.isPlaying {
+                        self.statusMessage = "Player pausado."
+                    }
+                case .waitingToPlayAtSpecifiedRate:
+                    self.statusMessage = "Aguardando buffer/reconexão..."
+                @unknown default:
+                    self.statusMessage = "Estado do player desconhecido."
+                }
+            }
+            .store(in: &cancellables)
+
+        NotificationCenter.default.publisher(for: .AVPlayerItemFailedToPlayToEndTime)
+            .receive(on: DispatchQueue.main)
+            .sink { [weak self] _ in
+                self?.statusMessage = "Falha no stream. Tentando reconectar..."
+                self?.retry()
+            }
+            .store(in: &cancellables)
+    }
+}
