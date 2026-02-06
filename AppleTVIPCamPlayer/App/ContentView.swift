diff --git a/AppleTVIPCamPlayer/App/ContentView.swift b/AppleTVIPCamPlayer/App/ContentView.swift
new file mode 100644
index 0000000000000000000000000000000000000000..f09669f5f6d2c252d91f987812791c8438a6fa47
--- /dev/null
+++ b/AppleTVIPCamPlayer/App/ContentView.swift
@@ -0,0 +1,85 @@
+import SwiftUI
+
+struct ContentView: View {
+    @EnvironmentObject private var viewModel: PlayerViewModel
+
+    var body: some View {
+        NavigationStack {
+            VStack(spacing: 24) {
+                PlayerView()
+                    .frame(maxWidth: .infinity)
+                    .frame(height: 500)
+
+                VStack(alignment: .leading, spacing: 12) {
+                    HStack(spacing: 12) {
+                        Picker("Protocolo", selection: $viewModel.scheme) {
+                            Text("RTSP").tag("rtsp")
+                            Text("HTTP").tag("http")
+                            Text("HTTPS").tag("https")
+                        }
+                        .frame(width: 220)
+
+                        TextField("IP da câmera", text: $viewModel.cameraHost)
+                        TextField("Porta", text: $viewModel.cameraPort)
+                            .frame(width: 120)
+                        TextField("Path", text: $viewModel.streamPath)
+                            .frame(width: 180)
+                    }
+
+                    TextField("URL customizada (opcional)", text: $viewModel.customURL)
+                        .textInputAutocapitalization(.never)
+                        .disableAutocorrection(true)
+
+                    HStack(spacing: 12) {
+                        TextField("Usuário", text: $viewModel.username)
+                            .textInputAutocapitalization(.never)
+                            .disableAutocorrection(true)
+
+                        SecureField("Senha", text: $viewModel.password)
+                    }
+
+                    Text("URL gerada: \(viewModel.generatedURL)")
+                        .font(.footnote)
+                        .foregroundStyle(.secondary)
+
+                    Text(viewModel.netipHint)
+                        .font(.footnote)
+                        .foregroundStyle(.yellow)
+
+                    Text(viewModel.statusMessage)
+                        .font(.callout)
+                        .foregroundStyle(.secondary)
+                }
+
+                HStack(spacing: 20) {
+                    Button("Aplicar configuração enviada") {
+                        viewModel.applyProvidedCameraConfig()
+                    }
+                    .buttonStyle(.bordered)
+
+                    Button("Reproduzir") {
+                        viewModel.play()
+                    }
+                    .buttonStyle(.borderedProminent)
+
+                    Button("Parar") {
+                        viewModel.stop()
+                    }
+                    .buttonStyle(.bordered)
+
+                    Button("Reconectar") {
+                        viewModel.retry()
+                    }
+                    .buttonStyle(.bordered)
+                }
+            }
+            .padding(36)
+            .navigationTitle("IP Camera Player (Apple TV)")
+        }
+    }
+}
+
+#Preview {
+    ContentView()
+        .environmentObject(PlayerViewModel())
+}
