class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.75"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/0.0.75/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "877877de7b83f650376185892132fd05c1bcee6aedd3e11c87982955d42cfdd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/0.0.75/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "99d49af740f90de5257037ed507d008cfbba8fea74dee65219e5ae7cb74c1eb7"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/0.0.75/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "7deb5a64027b0e836a62999a1c49b1bcec7890177891ad3d21923f4677add2cd"
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
