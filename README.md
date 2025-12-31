# Encora Stream Documentation

Official documentation for the Encora Stream live streaming platform.

### Prerequisites

- Ruby 2.7 or higher
- Bundler
- Jekyll

### Running Locally

```bash
bundle install
bundle exec jekyll serve
```

- If we encounter SSL issues on remote theme:

```bash
RUBYOPT="-r ./disable_ssl.rb" bundle exec jekyll serve --livereload
```

Visit http://localhost:4000 to view the documentation.

## Contributing

To update documentation:

1. Edit markdown files in the `docs/` directory
2. Test locally with Jekyll
3. Submit pull request with changes


## License

Copyright © 2024-2030 Encora Stream. All rights reserved.

