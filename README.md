# fuse

It combines things with other things, to make new things.

### Development

Check out the repo, run `bin/setup`. Then you need to [create a GitHub App](https://github.com/settings/apps/new). Once you've done that, you can build a `.env` file that will connect this repo to your new shiny app.

First, get the App ID from the page on GitHub you see after creating an app.

```bash
$ echo GITHUB_APP_ID=GITHUB_TELLS_YOU_THIS_ON_THE_APP_PAGE > .env
```

Then, push the button to generate and download a private key for your app, and use the path to that file here:

```bash
$ echo GITHUB_APP_PRIVATE_KEY=\"$(awk '{printf "%s\\n", $0}' /path/to/downloaded.pem)\" >> .env
```

Finally, generate a webhook secret, add it to the `.env` file, and then add it to the app config and save.

```bash
$ echo GITHUB_WEBHOOK_SECRET=$(uuidgen) > .env
```

Now run `ngrok 3000` and `bin/rails server`, and you are ready to go.