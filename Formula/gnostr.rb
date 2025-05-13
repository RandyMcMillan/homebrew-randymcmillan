class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.74"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.74/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "599ca268d145b542e7768d364f3a5b679e952814f41e61f6df80d90b4e9ab063"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.74/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "8e9aaee25595e1ac152d7816ba8d4e4fe90865dcbcc2dad6d18afb8bec4b1991"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.74/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ac0559fc2c3aa87786d2cc524340333dcf73fc1b45b50750833eef74e3d8a2a1"
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
