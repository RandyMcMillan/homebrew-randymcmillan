class VipeRs < Formula
  desc "Edit piped input in your editor"
  homepage "https://github.com/randymcmillan/vipe-rs"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/vipe-rs/releases/download/v0.0.7/vipe-rs-aarch64-apple-darwin.tar.xz"
      sha256 "8e06ab141c0520c29f723189783e3b55622bf9ffeaae0c8a8367cb06097c2923"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/vipe-rs/releases/download/v0.0.7/vipe-rs-x86_64-apple-darwin.tar.xz"
      sha256 "6d2609f5d4f37be2fb371621193f89ed4e02cc04ed1b2f900a7fc8755d0fce1b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/randymcmillan/vipe-rs/releases/download/v0.0.7/vipe-rs-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e1574582da933768778a8938d2b3b9792692e175c6fdc35702c0ed67f1463ab9"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "vipe" if OS.mac? && Hardware::CPU.arm?
    bin.install "vipe" if OS.mac? && Hardware::CPU.intel?
    bin.install "vipe" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
