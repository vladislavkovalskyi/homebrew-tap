cask "saytype" do
  version "0.1.2"
  sha256 "89cfbc4ed143529a76a9982b9cd6d4d9e75ce2324f13c651ce4d4f7658f93610"

  url "https://github.com/vladislavkovalskyi/saytype/releases/download/v#{version}/saytype-#{version}.dmg"
  name "saytype"
  desc "Local push-to-talk dictation"
  homepage "https://github.com/vladislavkovalskyi/saytype"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Sparkle updates the app in place; `brew upgrade --greedy` upgrades it too.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "saytype.app"

  # Releases are not notarized yet, so Gatekeeper would refuse the first launch.
  # Clearing the quarantine flag opens the app as if it came from a trusted source.
  # Remove this block once releases are notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/saytype.app"],
        writable_paths: ["{{appdir}}/saytype.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.kovalskyi.saytype",
    "~/Library/Caches/dev.kovalskyi.saytype",
    "~/Library/Preferences/dev.kovalskyi.saytype.plist",
  ]
end
