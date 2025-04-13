class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.53"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.53/gnostr-x86_64-apple-darwin.tar.xz"
    sha256 "403a5513b150932a196a58c3845c328ff696746023ff5f2298b81cc2e64e5787"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.53/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "2dfe91d451b17adcc5d72dc8c09a5e5ad2825f94a2b2d02bd42264ed03f21568"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
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
    bin.install "gnostr" if OS.mac? && Hardware::CPU.arm?
    bin.install "gnostr" if OS.mac? && Hardware::CPU.intel?
    bin.install "gnostr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
