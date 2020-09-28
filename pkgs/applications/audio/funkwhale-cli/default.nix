{ lib, python3Packages, fetchgit }:

python3Packages.buildPythonApplication rec {
  pname = "funkwhale-cli";
  version = "2020-09-25";

  src = fetchgit {
    url = "https://dev.funkwhale.audio/funkwhale/cli.git";
    rev = "2747ae68792ff0eb353a075e6ed376b25b187942";
    sha256 = "1g95dzplnikp89ykpsn72bix7ff5lp2g5v0qcz99pk2p82rv6p3x";
  };

  propagatedBuildInputs = with python3Packages; [
    aiofiles
    aiohttp    
    appdirs
    click
    click-log    
    keyring
    secretstorage
    marshmallow    
    python-dotenv
    semver
    tabulate
    tqdm
    #pathvalidate TODO add
  ];

  patches = [
    ./patches/0001-nixos-install-hackzz.patch
    ./patches/0002-Revert-Support-for-Bearer-application-token.patch
  ];

  doCheck = false;

  meta = with lib; {
    description = "Command line interface to interact with a Funkwhale server";
    homepage = "https://docs.funkwhale.audio/cli/index.html";
    maintainers = with maintainers; [ cryptix ];
    platforms = platforms.all;
  };
}

