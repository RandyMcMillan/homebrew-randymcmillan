class LightningSearch < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.35"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.35/lightning-search-aarch64-apple-darwin.tar.xz"
      sha256 "b4ec9bd0d6ca34dbe7632bb9ccd287e000538026d0b558346633d8621a34c559"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.35/lightning-search-x86_64-apple-darwin.tar.xz"
      sha256 "8fb435730271b38c81e68b734a37d702a62dad9a73a58c5818df5ff7e9354ed9"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.35/lightning-search-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "873dd8d3ef98952e6bac8d75fa3ca436554ca5733e4b387a1989f88af9db62cd"
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
