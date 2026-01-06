class Gtr < Formula
  desc "rust implementation of gittorrent"
  homepage "https://github.com/RandyMcMillan/gtr"
  version "0.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.8/gtr-aarch64-apple-darwin.tar.xz"
      sha256 "72e5b6ca81a512769fc21ef2ffa0d28010daad24d490b92364893d321b9e19e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.8/gtr-x86_64-apple-darwin.tar.xz"
      sha256 "a5c79692574e666cd6b34e79b6da425c6588672b09f2e6cd07f4b56feef1a796"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.8/gtr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4024117ab5a5a871b5a566a409813e50d962801c9dfcc4ab46a2e09f5b02d019"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.8/gtr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b57d2c2c7c93a96c102fd6ce427c16807ff3378207cb77d421e5731a91509828"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

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
    bin.install "gtr" if OS.mac? && Hardware::CPU.arm?
    bin.install "gtr" if OS.mac? && Hardware::CPU.intel?
    bin.install "gtr" if OS.linux? && Hardware::CPU.arm?
    bin.install "gtr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
