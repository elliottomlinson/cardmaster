# Importing Cards

This process imports all cards that have been printed into Tabletop Simulator.

To print cards, follow [this guide](printing.md).

### Setup

Install Gems: `bundle install`

Locate your Tabletop Simulator Saved Objects folder. Export that path into an environment variable:
```export TABLETOP_SAVED_OBJECTS_FOLDER="/path/to/saved/objects"```

### Running the Import script

You can call the script with `ruby src/import-cards.rb`. After it executes you should see your cards appear in Tabletop Simulator in the Saved Objects folder in "Cardmaster/Cards/Individual". They're imported as individual objects, deck based importing is still TBD

### Gotchas

- If your cards aren't updating in Tabletop Simulator, try to disable mod caching via "Configuration>Game>Disable Mod Caching"
- Tabletop Simulator is looking at the master branch on Github to find the images, so if you have changes to cards you've made locally or on a branch they won't appear in Tabletop Simulator.
- The Script reads the print manifest to determine what cards need to be imported. This manifest includes all the cards that were updated the last time cards were stored. The current implementation prints ever card everytime, so every time you run this script ever card should be updated.
