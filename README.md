Simple API serving up my Project Euler solutions.

Get this package and the project-euler library:
```
mkdir ~/project-euler
cd ~/project-euler
git clone https://github.com/mattjbray/project-euler-haskell.git
git clone https://github.com/mattjbray/project-euler-haskell-servant.git
```

Tell Nix about the project-euler package:
```
# ~/.nixpkgs/config.nix
{
  packageOverrides = super: let self = super.pkgs; in
  {
    haskell = super.haskell // {
      packages = super.haskell.packages // {
        ghc7101 = super.haskell.packages.ghc7101.override {
          overrides = self: super: {
            project-euler = self.callPackage ~/project-euler/project-euler-haskell {};
          };
        };
      };
    };
  };
}
```

Run the server:
```
cd ~/project-euler/project-euler-servant
nix-shell
cabal run
```

The server should be running at http://localhost:8000/solve/1
