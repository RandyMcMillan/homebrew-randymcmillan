class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.57"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.57/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "f3fa82c04226eb0eb6c69f0764d2962ab39be19b5fd56f71ad2651bbdf0fcece"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.57/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "71d7f86aa8dbc71bdfa9e61fd08de415f86d3bffa4941f6ca78829863fa85d14"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.57/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "bd06b4af2d014a4ba463688f92138f84971d04f894cd19f76815eeefd8e1c29e"
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
    bin.install "chat", "git_remote_nostr", "gnostr", "gnostr-tui", "ngit" if OS.mac? && Hardware::CPU.arm?
    bin.install "chat", "git_remote_nostr", "gnostr", "gnostr-tui", "ngit" if OS.mac? && Hardware::CPU.intel?
    bin.install "chat", "git_remote_nostr", "gnostr", "gnostr-tui", "ngit" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
