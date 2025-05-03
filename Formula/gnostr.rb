class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.63"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.63/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "ffffbc653f39b23dab678b6cb17e32400587a16cb944a8cc9d41330c0347f703"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.63/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "a17afa91143700bedafdb04eb0920c6a16a07ca0507d6369d78eab338a17a9ca"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.63/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1ca865969a0ae045e2d96963a96e5e5bae23cb5f9390f53ad21f6647eaa93d68"
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
