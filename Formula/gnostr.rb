class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.65"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.65/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "f077ce5b86b27e5ddd0f79a1ce6d5f33c171fe8c76bdf915c9c45e00d6fd9c57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.65/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "5e22e4c102955aeb8282e277f4241c650eb7e1144002a98d477fe2cba9bf0864"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.65/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4ec61c476c72204817fc8dddb72f0c6d328e9ae9893841f13f2b5347f516f562"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "git_remote_nostr", "gnostr", "gnostr-chat", "gnostr-tui", "ngit" if OS.mac? && Hardware::CPU.arm?
    bin.install "git_remote_nostr", "gnostr", "gnostr-chat", "gnostr-tui", "ngit" if OS.mac? && Hardware::CPU.intel?
    bin.install "git_remote_nostr", "gnostr", "gnostr-chat", "gnostr-tui", "ngit" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
