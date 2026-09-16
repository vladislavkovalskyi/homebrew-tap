cask "saytype" do
  version "0.2.0"
  sha256 "c1b24bb56f6a400f6f3e82d73cbe6c13d3a60f8bb0e8145a42ccc9b478c97be6"

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
