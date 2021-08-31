# Card Module

Contains components and models which support the specification, generation, and storage of Cardmaster cards.

### Catalogue Adapters

Catalogue Adapters provide an interface for fetching card specifications. A card specification contains all the information necessary to generate a card image, such as the card's title.

Only one catalogue adapter is currently supported, the JSON Catalogue Adapter.

#### JSON Catalogue Adapter
The JSON Catalogue Adapter reads a directory in the local filesystem and extracts card specifications from each JSON file present.

The JSON Catalogue Adapter expects cards to be specified in this format:
```json
{
  "title": "Foo",
  "upgrade": "Bar",
  "tier": "blue",
  "details": {
    "rules": {
      "cast": "Oh no",
      "hand": null
    },
    "flavour": "Darn",
    "image": "res/card/art/illustration/Inner Sun.png"
  }
},
```

Each individual file in the directory must have a `.json` file extension, and be constructed as follows:
```json
[
  { ... Card Specification ... },
  { ... Card Specification ... },
  ...
]
```

Within an individual file, folders can be specified to further organize the card specifications:
```json
[
  {
    "folder": "example-series",
    "content": [
      { ... Card Specification ... },
      { ... Card Specification ... },
      ...
    ]
  }
]
```

Folder and file names are both included as tags on the individual cards when they're later stored.

### Generators

Generators receive card specifications and generate images for the front and back of the cards.

The only card generator currently support is the IMGKit Generator.

#### IMGKit Generator

The IMGKit Generator uses IMGKit to render an HTML/CSS file into a `.png` image.

The HTML file comes from a mustache template that has information from the card specification injected into it.

### Storage Adapters

Storage Adapters take generated cards and persist them. The artifact of that persistence is a URL for the front and back of the card.

The only storage adapter currently supported is the Git storage adapter

#### Git Storage Adapter

The Git storage adapter saves the card images into your local clone of this repository.

The URLs returned point to the master branch of this repository. You must merge in your cards into Github before these links will work.
