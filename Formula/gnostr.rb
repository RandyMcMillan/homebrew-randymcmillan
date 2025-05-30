class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.81"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.81/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "e7bc6badf25f3cac42937f43dc3b01d4763e8c8d99bee36a9eb0a4e1b2eb7a88"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.81/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "b6876753dd2d27c1709d6331f1fd4e99cf8f140c19669cc10b3e562ea7611712"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.81/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1d5e0d27b835d3011d5f6d70e575185eff1c57c86f9106e12f4303cfa46daf33"
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
    bin.install "git_remote_nostr", "gnostr" if OS.mac? && Hardware::CPU.arm?
    bin.install "git_remote_nostr", "gnostr" if OS.mac? && Hardware::CPU.intel?
    bin.install "git_remote_nostr", "gnostr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
