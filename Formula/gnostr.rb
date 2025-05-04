class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.64"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.64/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "5c9af11b923c92e31bb454c526e5a8a8bc6f72543ec4d20083ca825e834b82ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.64/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "8e489a81c0d209da449cfa15c0e6cf1e03fb0da73e35e293e3801f455d2214dc"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.64/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "31dbd07debc728bef37f15bb84ca32500be649c6df43e103f01f1f0bec142468"
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
