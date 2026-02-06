diff --git a/AppleTVIPCamPlayer/App/PlayerView.swift b/AppleTVIPCamPlayer/App/PlayerView.swift
new file mode 100644
index 0000000000000000000000000000000000000000..28ef76e0c44e755bc4d2b859617a5af5a5ee72cb
--- /dev/null
+++ b/AppleTVIPCamPlayer/App/PlayerView.swift
@@ -0,0 +1,20 @@
+import AVKit
+import SwiftUI
+
+struct PlayerView: View {
+    @EnvironmentObject private var viewModel: PlayerViewModel
+
+    var body: some View {
+        VideoPlayer(player: viewModel.player)
+            .overlay(alignment: .topLeading) {
+                if !viewModel.isPlaying {
+                    Label("Sem reprodução ativa", systemImage: "video.slash")
+                        .padding(10)
+                        .background(.ultraThinMaterial)
+                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
+                        .padding()
+                }
+            }
+            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
+    }
+}
