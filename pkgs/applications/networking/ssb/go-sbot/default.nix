{ stdenv, pkgconfig, libappindicator-gtk3, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "gosbot-unstable-${version}";
  version = "0.0.0";
  rev = "976fdaa25fb5e3aa1259a6db88269e68650c60ca";

  goPackagePath = "go.cryptoscope/ssb/cmd/go-sbot";

  src = fetchFromGitHub {
    inherit rev;
    owner = "cryptoscope";
    repo = "ssb";
    sha256 = "03kapjsfrw4x171j3cn20901gjcv5aav1ny3app9wf4mmbqvs184";
  };

  # re date: https://github.com/NixOS/nixpkgs/pull/45997#issuecomment-418186178
  # > .. keep the derivation deterministic. Otherwise, we would have to rebuild it every time.
  buildFlagsArray = [ ''-ldflags=
    -X main.version=v${version}
    -X main.commit=${rev}
    -X main.date="nix-byrev"
    -s
    -w
  '' ];

  meta = with stdenv.lib; {
    description = "the compiled sbot";
    homepage    = "https://github.com/cryptoscope/ssb";
    maintainers = with maintainers; [ cryptix ];
    platforms   = platforms.all;
  };
}
