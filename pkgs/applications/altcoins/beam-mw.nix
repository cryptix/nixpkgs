{ mkDerivation, lib, fetchFromGitHub
, openssl, boost, cmake, qtbase, qtdeclarative }:

mkDerivation rec {
  src = fetchFromGitHub {
    owner = "beam-mw";
    repo = "beam";
    rev = "6ce6a409c839ce7cebb0aa1a7cc1d1154458a07e";
    sha256 = "0z94xp0f1ldly96crjlv5bwjbb5r32hzx9v8zi8hdk7syjp748bx";
  };

  name = "beam-mw-git";

  nativeBuildInputs = [ cmake ];
  buildInputs = [ openssl boost qtbase qtdeclarative ];

  cmakeFlags = [
	"-DCMAKE_BUILD_TYPE=Release"
  ];

  configureFlags = [ "--with-boost-libdir=${boost.out}/lib" ];

  meta = {
    description = "BEAM Mimblewimble";
    longDescription= ''
		Some cryptocurrency.
    '';
    homepage = https://beam-mw.com/;
   # platforms = platforms.unix;
 #   license = licenses.apache2;
    #maintainers = with maintainers; [ offline AndersonTorres ];
  };
}
