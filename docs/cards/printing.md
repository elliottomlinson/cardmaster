# Printing Cards

The following is a guide on specifying, printing, and importing action cards.

### Setup

- Clone this repository
- [Install libvips](https://libvips.github.io/libvips/install.html)
- Install gems: `bundle install`

### Card Catalogue

Cards are specified using the [JSON card catalogue](../../data/card_catalogue.json).

For now, the folders can be ignored. 

The cards should be in this form: 
```json
{
  "title": "Foo",
  "upgrade": "Bar",
  "tier": "blue",
  "details": {
    "rules": "Deal X damage to every non-player character you've ever known, where X is the number of complaints you can  list in 30 seconds",
    "flavour": "\"The world is irredeemable. I have yet to meet a soul worth saving.\" -Fester the Limp",
    "image": "assets/core/card/illustration/Inner\ Sun.png"
  }
}
```

Images should be stored in the [illustrations folder](../../assets/core/card/illustration) in your local filesystem.

Make sure that your tier is one of grey, blue, green, red, or gold.

Cards with the `"draft"` flag set will be ignored when generating and importing.

### Generating the Images

To generate the images, run a ruby script: `ruby src/card/generate_card_assets.rb`

This'll write the images into the [printed folder](../../assets/core/card/printed).

You can review the images now to ensure that they printed as expected. If they look good, you can proceed to the next step.

You can change the dimensions of the template components by changing the constants in [the vips generator file](src/card/generators/vips_basic.rb). The backdrop images are stored in the [template folder](src/card/generators/vips_basic.rb). The sizes of those templates must match the constants in the vips generator file. 

### Hosting the Images

Images are hosted on the repositories master branch in Github.

Create a new git branch and commit your changes to the Card Catalogue, all the new images, and the print manifest. 

Push up the branch and make a PR to review the changes to cards. Once this PR is merged, any changes to previously existing cards will take effect in Tabletop Simulator since we always reference the latest version of the card.

### Next Steps

Your card images are now being hosted by Github.

To use those images in Tabletop Simulator follow [this guide](importing.md)
