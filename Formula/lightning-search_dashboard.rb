class LightningSearchDashboard < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.52"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.52/lightning-search_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "374d52ad1c12a46111edaf28913f525974f89456a02664ddae08788e3755a065"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.52/lightning-search_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "427cce74177bdbd177d8acbcfcda7140859dc2b610cdc78488c25c8c0c8e8c79"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.52/lightning-search_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b88de920cecaf74defcdd445220201f94795fbf8c9a00a110e7d0a784210e0de"
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
      bin.install "lightning-search_dashboard"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lightning-search_dashboard"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lightning-search_dashboard"
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
