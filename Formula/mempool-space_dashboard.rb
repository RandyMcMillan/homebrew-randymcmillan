class MempoolSpaceDashboard < Formula
  desc "mempool.space api interface."
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.45"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.45/mempool-space_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "4f573ec7adee2a486ae4c5583985522763452b58ba5d59782f1c033b561b10ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.45/mempool-space_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "c367e0f58d8bb4fcb9c8cd38d0240670a8736912d5f745f79d8460486b438228"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.45/mempool-space_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8577499e73bba051b577a7c4de6fdd484ea30dcb2ad5430114228d15e8ef0b33"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mempool-space_dashboard"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mempool-space_dashboard"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mempool-space_dashboard"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
