# About

This branch was created from branch `update_bounds_ghc_9_8_1` with the following command `git subtree split --prefix=protoc --branch=ghc_981_protoc`.

To work around symlinks error as:

```
ERROR: An error occurred during the fetch of repository 'stackage':
   Traceback (most recent call last):
	File "D:/a/rules_haskell/rules_haskell/haskell/cabal.bzl", line 1921, column 37, in _stack_snapshot_impl
		resolved = _resolve_packages(
	File "D:/a/rules_haskell/rules_haskell/haskell/cabal.bzl", line 1340, column 42, in _resolve_packages
		exec_result = _execute_or_fail_loudly(
	File "D:/a/rules_haskell/rules_haskell/haskell/private/workspace_utils.bzl", line 27, column 13, in execute_or_fail_loudly
		fail("\n".join(["Command failed: " + " ".join(arguments), exec_result.stderr]))
Error in fail: Command failed: C:/_bzl/minshlu6/external/rules_haskell_stack/stack ls dependencies json --global-hints --external
Cloning 42f04c3f639f10dc3c7981a0c663bfe08ad833cb from https://github.com/tweag/cabal
Cloning d59e535092c5cc96c5c35358915b22163ff6f6c1 from https://github.com/avdv/proto-lens
Error: [S-760]
       Unsupported tarball from
       C:\Users\runneradmin\AppData\Local\Temp\with-repo-archive5680\foo.tar:
       
       Symbolic link dest not found from proto-lens-protobuf-types/proto-src to ../google/protobuf/src/, looking for google/protobuf/src.
       This may indicate that the source is a git archive which uses git-annex.
       See https://github.com/commercialhaskell/stack/issues/4579 for further information.
ERROR: D:/a/rules_haskell/rules_haskell/WORKSPACE:150:15: fetching _stack_snapshot rule //external:stackage: Traceback (most recent call last):
	File "D:/a/rules_haskell/rules_haskell/haskell/cabal.bzl", line 1921, column 37, in _stack_snapshot_impl
		resolved = _resolve_packages(
	File "D:/a/rules_haskell/rules_haskell/haskell/cabal.bzl", line 1340, column 42, in _resolve_packages
		exec_result = _execute_or_fail_loudly(
	File "D:/a/rules_haskell/rules_haskell/haskell/private/workspace_utils.bzl", line 27, column 13, in execute_or_fail_loudly
		fail("\n".join(["Command failed: " + " ".join(arguments), exec_result.stderr]))
```
