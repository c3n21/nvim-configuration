{
  lib,
  fetchFromGitHub,
  buildDotnetModule,
}:

buildDotnetModule rec {
  pname = "easy-dotnet-server";
  name = pname;
  # version = "1.0.1";

  src = fetchFromGitHub {
    owner = "GustavEikaas";
    repo = pname;
    rev = "fb9f2da82cfe8c89c7bed81de7bbcf313104b3bb";
    sha256 = "sha256-fRcGkw1lNPHs6uKG71l9FCXjiYkEQIzZmv3GwMjc/YU=";
  };

  nugetDeps = ./deps.json;
  projectFile = "EasyDotnet.sln";

  meta = with lib; {
    description = "Simple and easy .NET server";
    homepage = "https://github.com/GustavEikaas/easy-dotnet-server";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
