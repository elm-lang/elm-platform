## Uploading new binaries

1. Assemble the `.tar.gz` files listed in `binaries.json`. Each tarball should contain a directory (e.g. `Elm-Platform-0.15`, although the directory name does not matter) whose contents are the binaries like `elm-make` for the appropriate environment. (See [os-filter-obj](https://github.com/kevva/os-filter-obj) for the available OS and architecture strings.)
2. Sign into [the elm-platform npm binaries upload page](https://bintray.com/elmlang/elm-platform/npm/1/upload)
3. Enter the version number (e.g. `0.15.1`) under **Target Repository Path**.
4. Click **Upload Files** and select the `.tar.gz` files from earlier. (You can multi-select in the dialog.)
5. Once everything is done uploading, hit **Save Changes**. You should now see each of the files listed at the bottom of the page, along with an auto-generated `.asc` file which contains a PGP signature so people can verify the files were downloaded correctly.
6. If everything looks right, hit **Publish** to make them available for download.
