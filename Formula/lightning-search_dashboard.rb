class LightningSearchDashboard < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.58"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.58/lightning-search_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "680b4a0e2ca6d18d765159cada370996e89206661392a4ce6c72d4e916a0c75a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.58/lightning-search_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "cfa22de75d73ddaf41b0a221efcdaba3878fcc157eb91705716283ec3304764b"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.58/lightning-search_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b0a1ae67596dadf506dc8e847c3251856c31a8ceacef7217631adb65f931f58"
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
