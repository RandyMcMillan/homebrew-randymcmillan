class LightningSearchDashboard < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.50"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.50/lightning-search_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "e2a011d53e713fabbb2f22fb8fd2c6f5023501f1a4abdaaf47f9f8ccdf1e069c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.50/lightning-search_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "53c73ec8c790eae9330975afb7be38cd67052a1f0415b70cfa1fae7b6e596f68"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.50/lightning-search_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "046a7f2370bf030d4ce09b2d59f694f0bee75149c126b6183101781242441be2"
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
