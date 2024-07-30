class MempoolSpace < Formula
  desc "mempool.space api interface."
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.3/mempool_space-aarch64-apple-darwin.tar.xz"
      sha256 "e3a81ca314131ea3c337c6c6596a59d11671bee7dc7a7d451b2d7db57b908b6f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.3/mempool_space-x86_64-apple-darwin.tar.xz"
      sha256 "c59ba86800cf93c417d43a0390a902ce3ae1d16c2520000b8f94c228fbd7d435"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.3/mempool_space-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "116ee1e62f191847acd16a742af3268caa3513916252f177c85d83f95ef9c8e0"
    end
  end
  license "MPL-2.0"

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
      bin.install "address", "address-txs", "address-txs-chain", "address-txs-mempool", "address-utxo", "block", "block-header", "block-height", "block-raw", "block-status", "blocks", "blocks-height", "blocks-tip", "blocks-tip-hash", "blocks-tip-height", "difficulty-adjustment", "historical-prices", "mining-blocks-timestamp", "prices", "reachable", "validate-address"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "address", "address-txs", "address-txs-chain", "address-txs-mempool", "address-utxo", "block", "block-header", "block-height", "block-raw", "block-status", "blocks", "blocks-height", "blocks-tip", "blocks-tip-hash", "blocks-tip-height", "difficulty-adjustment", "historical-prices", "mining-blocks-timestamp", "prices", "reachable", "validate-address"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "address", "address-txs", "address-txs-chain", "address-txs-mempool", "address-utxo", "block", "block-header", "block-height", "block-raw", "block-status", "blocks", "blocks-height", "blocks-tip", "blocks-tip-hash", "blocks-tip-height", "difficulty-adjustment", "historical-prices", "mining-blocks-timestamp", "prices", "reachable", "validate-address"
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
