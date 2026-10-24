cask "vibecode24" do
  version "0.1.0"
  sha256 "f9899f4cce0c7ba06ba4b55326862a1bc878298c296fba018caa993bd95873c1"

  url "https://github.com/vladislavkovalskyi/vibecode24/releases/download/v#{version}/Vibecode24-#{version}.dmg"
  name "Vibecode24"
  desc "Keep a MacBook awake with the lid closed while AI coding agents run"
  homepage "https://github.com/vladislavkovalskyi/vibecode24"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Vibecode24.app"

  # Releases are not notarized yet, so Gatekeeper would refuse the first launch.
  # Clearing the quarantine flag opens the app as if it came from a trusted source.
  # Remove this block once releases are notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Vibecode24.app"],
        writable_paths: ["{{appdir}}/Vibecode24.app"]
  end

  # Quitting the app gives sleep back (pmset -a disablesleep 0) before it exits.
  uninstall quit: "com.vladislavkovalskyi.vibecode24"

  zap trash: "~/Library/Preferences/com.vladislavkovalskyi.vibecode24.plist"

  caveats <<~EOS
    Lid-closed mode installs /etc/sudoers.d/vibecode24 after one admin prompt.
    Remove it in Vibecode24 Settings -> Safety, or run:
      sudo rm /etc/sudoers.d/vibecode24
  EOS
end
