class MakeJust < Formula
  desc "The make-just application"
  homepage "https://github.com/randymcmillan/make-just"
  version "0.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.8/make-just-aarch64-apple-darwin.tar.xz"
      sha256 "3e71be9af5dba00396c52832597b97cc2eb9075525795978362818fb534b1487"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.8/make-just-x86_64-apple-darwin.tar.xz"
      sha256 "403fd8fbc3b264a18c3c02b784ab0a364cdaf8254a95fa20d96382b58e950514"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.8/make-just-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3203a1a2c7d6bb3d1a8308b879fb6a718f06c905f373d0a81536611840dbcf5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.8/make-just-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e735d933fdf92c74a703904424bddbaf09d2d002f702b5e0ee6076386a5920c6"
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
