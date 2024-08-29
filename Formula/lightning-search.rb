class LightningSearch < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.39"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.39/lightning-search-aarch64-apple-darwin.tar.xz"
      sha256 "d250f5358eb32c9f6bbe27e88a796bb61a854e50089ed2d5b863eb642184d336"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.39/lightning-search-x86_64-apple-darwin.tar.xz"
      sha256 "20575758725200954fe759a1a2aaf3ad20e920d089472f5a8b34084753bf43e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.39/lightning-search-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a2f4455141671636663b85cd3d0b7a44ca1f3fa986af891241ad46e0f9bb89d"
    end
  end
  license "MIT"

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
      bin.install "lightning-search"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lightning-search"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lightning-search"
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
