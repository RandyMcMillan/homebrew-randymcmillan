class VipeRs < Formula
  desc "Edit piped input in your editor"
  homepage "https://github.com/randymcmillan/vipe-rs"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/vipe-rs/releases/download/v1.0.0/vipe-rs-aarch64-apple-darwin.tar.xz"
      sha256 "3a9a40c1e9fe1732c948c8dfdd53e4ae8c55ac2dca647611c06e3c7077fe624c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/vipe-rs/releases/download/v1.0.0/vipe-rs-x86_64-apple-darwin.tar.xz"
      sha256 "1f478e8e8b8e623d2d64daf0491ca4dd6e402bca9da96ef595e67ba6346b1ae1"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/randymcmillan/vipe-rs/releases/download/v1.0.0/vipe-rs-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "938254aefd8999a41b85b34c0359ad978f84bd8baf2afa3cc1a8c0b51231465c"
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
