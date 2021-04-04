# Card Image Generator

This tool is intended to generate and store card images using information specified by a Card Catalogue.

At the moment it is hardcoded to generate a single mock card.

To generate the mocked card, first install libvips:
https://libvips.github.io/libvips/install.html

Then install the gems:
```
bundle install
```

Now you can generate the card by running
```
ruby src/card/generate_card_assets.rb
```

It'll save the file in "test.png"

To alter the look of the card, you can change the constants in `src/card/generators/vips_basic.rb` or overwrite the template images in `assets/core/card/template`
