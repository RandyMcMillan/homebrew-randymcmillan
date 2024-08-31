class LightningSearch < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/lightning-search-aarch64-apple-darwin.tar.xz"
      sha256 "44839a067ad4b7d8eb3872c91398b639ff6b3e0cc8a0afb1090a15c715622bfe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/lightning-search-x86_64-apple-darwin.tar.xz"
      sha256 "0a8b82e38acd6480279820aadc010728c69e17b55546a03cba061c504c4e207f"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/lightning-search-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d830e6bb0307db129a481c739dcf3c54d4b6902ddee44a436d7c01e2a6dafe85"
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
