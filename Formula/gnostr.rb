class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.76"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/0.0.76/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "4c5c23edfe3f42dd789f3446b8965046d3c0cc6113d15ebc3ea57bcced3a5b8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/0.0.76/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "20d88405af59323085d811cd9679a221d972ac4fca5614cd34f736b6d6d6411c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/0.0.76/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "b29eee59ea6df67e6af8b4f6d852877c0b2c69085efd91d4b75d03866dfbe90e"
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
