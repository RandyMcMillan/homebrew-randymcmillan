class MakeJust < Formula
  desc "The make-just application"
  homepage "https://github.com/randymcmillan/make-just"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.7/make-just-aarch64-apple-darwin.tar.xz"
      sha256 "952b1cfaa98b6f438a27138e19ec3c8608393eb465e31537ce176fa839fa35f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.7/make-just-x86_64-apple-darwin.tar.xz"
      sha256 "5986cbc2136d21e603ff20ebc08bdf48027c3e345e2c8e0ed854f2138b5bcb56"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.7/make-just-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "07785474500a3d33508c82a3da1dfaaf422170291bccaf1b7f58e682a8477974"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.7/make-just-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "26d22d9590f928a15d420b87055b618ac70d8f03fd7fe92a9167769789e291fd"
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
