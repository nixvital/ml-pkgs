final: prev: {
  aria-csv-parser = final.callPackage ../cc-batteries/aria-csv-parser {};
  cpp-sort = final.callPackage ../cc-batteries/cpp-sort {};
  scnlib = final.callPackage ../cc-batteries/scnlib {};
  unordered-dense = final.callPackage ../cc-batteries/unordered-dense {};
  xxhash-cpp = final.callPackage ../cc-batteries/xxhash-cpp {};
  vectorclass = final.callPackage ../cc-batteries/vectorclass {};
  eve = final.callPackage ../cc-batteries/eve {};

  quickcpplib = final.callPackage ../cc-batteries/ned14/quickcpplib {};
  status-code = final.callPackage ../cc-batteries/ned14/status-code {};
  outcome = final.callPackage ../cc-batteries/ned14/outcome {};  
}
