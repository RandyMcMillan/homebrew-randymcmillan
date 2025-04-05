class MakeJust < Formula
  desc "The make-just application"
  homepage "https://github.com/randymcmillan/make-just"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.6/make-just-aarch64-apple-darwin.tar.xz"
      sha256 "76fae68ded859079ed29a9a2f70aba708bd6e5332895660f5360b6f84aadca2b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.6/make-just-x86_64-apple-darwin.tar.xz"
      sha256 "830b094cee9ff02784b7b59291108476318765a28b2957b8b0a7d591b4e7b5d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.6/make-just-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "465d037d1d224aeb242fa499c1d386459bad52b241f2606b416b8c1f220f8c8d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.6/make-just-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e064ce928f575b577585e839d2e2c5fc4cc7b1394bc5ddf4a3b2a318a3b15bdd"
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
