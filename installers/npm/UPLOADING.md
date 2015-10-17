## Uploading new binaries

First, assemble the following files. Each should contain `elm-make` and so forth
for their respective environments.

1. `osx.tar.gz`
2. `win.tar.gz`
3. `linux-x64.tar.gz`

Next, publish them on Bintray:

1. Sign into [the elm-platform npm binaries upload page](https://bintray.com/elmlang/elm-platform/npm/1/upload)
2. Enter the version number (e.g. `0.15.1`) under **Target Repository Path**.
3. Click **Upload Files** and select the `.tar.gz` files from earlier. (You can multi-select in the dialog.)
4. Once everything is done uploading, hit **Save Changes**. You should now see each of the files listed at the bottom of the page, along with an auto-generated `.asc` file which contains a PGP signature so people can verify the files were downloaded correctly.
5. If everything looks right, hit **Publish** to make them available for download.
