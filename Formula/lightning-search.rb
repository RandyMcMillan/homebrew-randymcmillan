class LightningSearch < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.37"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.37/lightning-search-aarch64-apple-darwin.tar.xz"
      sha256 "f85a0cf172520a8598284db5147a2f4f93dad30ec1824cb5fe853ae052375877"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.37/lightning-search-x86_64-apple-darwin.tar.xz"
      sha256 "40d0bc5e7f189f2156c3add143614ccbc26625fcb97f971197fd55bef3411182"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.37/lightning-search-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "509e44caead76c5865fc9ef8ed23f1cbe0d79575ef3155907474af68a7849704"
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
