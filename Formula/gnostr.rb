class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.58"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.58/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "5240883bec4dc20ed80245d601768c57b797236525f386f71400dae7f6ed5acb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.58/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "20a6ecfaa7e2b863fd1dc8b29374777a959b841eab625fa17579dcff9a9974db"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.58/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d380e313bcef0b474dae9548c3d3fcf5354b2e9074d4c223ae5e16b60a27e3ad"
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
    bin.install "chat", "git_remote_nostr", "gnostr", "gnostr-tui", "ngit" if OS.mac? && Hardware::CPU.arm?
    bin.install "chat", "git_remote_nostr", "gnostr", "gnostr-tui", "ngit" if OS.mac? && Hardware::CPU.intel?
    bin.install "chat", "git_remote_nostr", "gnostr", "gnostr-tui", "ngit" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
