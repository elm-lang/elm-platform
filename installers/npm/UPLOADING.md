## Uploading new binaries

The first time you do this, you will need to set up a `bintray.json` file.
See below for how to set that up.

Once you have that set up, run this:

```
$ node upload.js 0.15.1 osx osx.tar.gz
```

Once this completes, your local file `binaries-for-osx-0.15.1.tar.gz` will now
be the new OS X binary bundle for Elm 0.15.1, meaning whenever anyone runs
`npm install elm` on OS X, they will get the binaries in that `.tar.gz` file.

## Setting up `bintray.json`

Make a file called bintray.json and put it in this folder. (That file is
already in .gitignore, so it won't accidentally get checked in.) It should
look something like this:

`bintray.json`
```
{
    "username": "rtfeldman",
    "key": "a29dfa02d34fea2df34f1ac3dac"
}
```

Replace the `username` field with your Bintray username, and the
`key` field with your Bintray API key.

To find your Bintray API key:

1. Sign in to [bintray.com](http://bintray.com)
2. Edit your profile
3. Click "API Key" at the bottom of the left nav bar

Now your `bintray.json` file is set up, and you can upload binaries.
