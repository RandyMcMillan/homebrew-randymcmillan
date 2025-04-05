class MakeJust < Formula
  desc "The make-just application"
  homepage "https://github.com/randymcmillan/make-just"
  version "0.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.9/make-just-aarch64-apple-darwin.tar.xz"
      sha256 "25352109689f3a0646a8e6bee843aa8bdbfdad18e52fc4ce3d1a96bf8ce59e85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.9/make-just-x86_64-apple-darwin.tar.xz"
      sha256 "6a03406d466b5ed2612b798b5094476c81d882b0e1cf8ad60487ddfaa2f9f8bc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.9/make-just-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c2d3b520fadb272162e9379ce733dbcad23c744cdd9893ed97d0b7e0ff02cb90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.9/make-just-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2728a399d038b5194bf79e3dcbedf2c865892c7669867d4e2be2fe1f40914391"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
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
    bin.install "make-just" if OS.mac? && Hardware::CPU.arm?
    bin.install "make-just" if OS.mac? && Hardware::CPU.intel?
    bin.install "make-just" if OS.linux? && Hardware::CPU.arm?
    bin.install "make-just" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
