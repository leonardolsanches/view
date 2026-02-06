diff --git a/AppleTVIPCamPlayer/App/CameraTVApp.swift b/AppleTVIPCamPlayer/App/CameraTVApp.swift
new file mode 100644
index 0000000000000000000000000000000000000000..f6f5c5cdffea8d45d78c4e02446023c1a55e460a
--- /dev/null
+++ b/AppleTVIPCamPlayer/App/CameraTVApp.swift
@@ -0,0 +1,13 @@
+import SwiftUI
+
+@main
+struct CameraTVApp: App {
+    @StateObject private var viewModel = PlayerViewModel()
+
+    var body: some Scene {
+        WindowGroup {
+            ContentView()
+                .environmentObject(viewModel)
+        }
+    }
+}
	
