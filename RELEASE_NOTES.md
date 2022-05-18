# Release notes

In the next release, I want :
* Standard operations implemented as npm scripts:
  * those npm scripts may execute any nodejs software
  * the implemented standard operations must be :
    * dev build :
    * dev start :
    * prod build
    * release
    * add a new resume entry
    * delete a resume entry (a resume entry is defined by the path of a markdown file) <!-- * modfying a resume entry is done by modifying the matching markdown file -->
    * list resume entries (`export PATH=$PATH:/usr/local/go/bin && hugo list future && hugo list all && hugo list drafts # etc...`)
    * list hugo content types ?
    * delete all hugo content entries
    * spawn the hugo project from the git SSH URI of any Hugo Theme :
      * It cleans up the entire hugo project
      * it creates a fresh hugo project
      * it spins up the `exampleSite`, and runs it locally (Ctrl + C to stop the `hugo` dev server)
    * tear down the hugo project :
      * back up all content entries, to the specified folder (`npm run hugo:content:backup -- ./myBackUp_folder` ...?)
      * delete all content entries
      * delete the hugo theme reference
    * flip hugo theme :
      * changing the hugo theme, but keeping all hugo content
      * this involves adding any new front matter data required by the
    * ccc


#### Build Specs

Build specs :
* Ability to compile SASS css files
* Image processing :
  * generate resized image files, to adapt to screen sizes
  * compress files
  * apply image special effects tranformations
* Ability to use `TypeScript` : compile
* Ability to deploy images to CDN instead of the static server (for staging and prod build and deployments)
* PurgeCss processing
* PostCSS porcessing
* Gulp build to be able to customize the gulp build
* Run locally with hot reloading: in "Watch mode"
* Tests :
  * Unit tests
  * cypress test
  * Playwright.dev tests
  *
* Ability to manage icons used in unfold social medias mode
* Ability to manage natural SEO



# The target `README.md`


## Run locally (Dev Build)

## Build and deploy a PR for PR review (Staging Build)

## Spawn the hugo project from a different theme
