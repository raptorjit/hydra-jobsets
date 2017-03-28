{ nixpkgs, declInput ? null }: let pkgs = import nixpkgs {}; in {
  jobsets = pkgs.runCommand "spec.json" {} ''
    cat > $out <<EOF
    {
      "hotcounts": {
        "enabled": 1,
        "hidden": false,
        "description": "Test the impact of HOTCOUNT table size",
        "nixexprinput": "testsuiteSrc",
        "nixexprpath": "testsuite/bench/default.nix",
        "checkinterval": 0,
        "schedulingshares": 100,
        "enableemail": false,
        "emailoverride": "",
        "keepnr": 3,
        "emailresponsible": false,
        "inputs": {
          "benchmarkRunsNix": { "type": "expression", "value": 300 },
          "hardware":     { "type": "string", "value": "murren" },
          "nixpkgs":      { "type": "git", "value": "https://github.com/NixOS/nixpkgs-channels.git nixos-16.03-small", "emailresponsible": false },
          "Aname":        { "type": "string", "value": "hot64" },
          "Asrc":         { "type": "git", "value": "https://github.com/lukego/raptorjit proto-entropy", "emailresponsible": false },
          "Bname":        { "type": "string", "value": "hot8" },
          "Bsrc":         { "type": "git", "value": "https://github.com/lukego/raptorjit hot8", "emailresponsible": false },
          "Cname":        { "type": "string", "value": "hot16" },
          "Csrc":         { "type": "git", "value": "https://github.com/lukego/raptorjit hot16", "emailresponsible": false },
          "Dname":        { "type": "string", "value": "hot256" },
          "Dsrc":         { "type": "git", "value": "https://github.com/lukego/raptorjit hot256", "emailresponsible": false },
          "Ename":        { "type": "string", "value": "hot1024" },
          "Esrc":         { "type": "git", "value": "https://github.com/lukego/raptorjit hot1024", "emailresponsible": false },
          "testsuiteSrc": { "type": "git", "value": "https://github.com/raptorjit/raptorjit-testsuite", "emailresponsible": false }
        }
      }
    }
    EOF
    echo "Generated spec.json:"
    cat $out
  '';
}


