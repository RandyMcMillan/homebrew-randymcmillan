class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.68"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.68/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "35cf11b5d03f5d695c3776ce3b1887d3e9e03bb49196a802710a79648ea638b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.68/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "70d2baaa7ae8c467276a8c0f0a3df6cca2acae62ff9395e217beec5212adfea2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.68/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "970d671cf12ee40e8041306c80daeb358787382bfdd9918ef752318dc7c5cb08"
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
