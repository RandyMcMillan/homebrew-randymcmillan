class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.77"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.77/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "05767faff5978320b68e7aa43002fe22a2e011bf73d199e173bfc92fd0b0f4f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.77/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "aaeef73121312a529a29ac714532c77326b534f9c686ebc222136baf0fbfb1d1"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.77/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "644864f3250f7243b59ba32e8084ad26b657e4311380cb071ee4b8a4bfdc4260"
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
    bin.install "git_remote_nostr", "gnostr", "sniper" if OS.mac? && Hardware::CPU.arm?
    bin.install "git_remote_nostr", "gnostr", "sniper" if OS.mac? && Hardware::CPU.intel?
    bin.install "git_remote_nostr", "gnostr", "sniper" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
