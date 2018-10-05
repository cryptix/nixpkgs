{ mkDerivation, lib, fetchFromGitHub, cmake, qtbase, qttools }:

mkDerivation rec {
  version = "2.1.0";
  name = "nodeeditor-${version}";

  src = fetchFromGitHub {
    repo   = "nodeeditor";
    owner  = "paceholder";
    rev    = "${version}";
    sha256 = "1vfldz01v86jxpr2l368ca9sjh682jicsh3vqph7cfpdn4ylcyqb";
  };

  buildInputs = [ qtbase ];
  nativeBuildInputs = [ cmake qttools ];
  enableParallelBuilding = true;

  postInstall = ''
    mkdir -p $out/bin
    find examples -type f -executable -exec cp -v {} $out/bin \;
  '';

  meta = with lib; {
    description = "Qt Node Editor. Dataflow programming framework ";
    homepage = https://github.com/paceholder/nodeeditor;
    license = licenses.gpl3;
    maintainers = with maintainers; [ cryptix ];
    platforms = platforms.linux; # maybe more?
  };
}
