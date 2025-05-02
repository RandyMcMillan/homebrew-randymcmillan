class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.60"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.60/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "6574d7f996a4ebfbbc9dbd09a23a897335c1266d57c1b09b72ab9ab2e5fccc1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.60/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "58376c9bdf61d312406fc1eb7cebebc70de1fe60ed4f47d934ca9a1857dd9d25"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.60/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e45883d7ba0f61ffa0974ccb1669601bf2e88c3cb3b17882633b3599fc8e8e60"
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
