class LightningSearch < Formula
  desc "The lightning_search application"
  version "0.0.27"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.27/lightning_search-aarch64-apple-darwin.tar.xz"
      sha256 "8596e9ac643f6d75ccfcb86a75b449c64b30dccb1932e7815a59927bd76c46d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.27/lightning_search-x86_64-apple-darwin.tar.xz"
      sha256 "a45b587acdcc9aa03e2a8b5ccc1b38b25e6d35661e8a267b39bef611c9b3a870"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.27/lightning_search-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b5442fefb829918eccababa240264c1286707f8d5869fdbae1dcaed80784e583"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "lightning_search"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lightning_search"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lightning_search"
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
