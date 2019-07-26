{ lib, bundlerEnv, ruby }:

bundlerEnv rec {
  name = "kramdown-${version}";

  version = (import ./gemset.nix).kramdown.version;
  inherit ruby;

  # expects Gemfile, Gemfile.lock and gemset.nix in the same directory
  gemdir = ./.;

  meta = with lib; {
    description = "A monitoring framework that aims to be simple, malleable, and scalable";
    homepage    = https://github.com/cabo/kramdown-rfc2629;
    license     = with licenses; mit;
    maintainers = with maintainers; [ cryptix ];
    platforms   = platforms.unix;
  };
}
