# Project 1 - Instagram

Instagram is an Instagram client.

Time spent: 9 hours spent in total

## Milestones

- [x] Milestone 1: Setup
- [x] Milestone 2: Hookup the Instagram API
- [x] Milestone 3: Build the Main Photo Feed
- [x] Milestone 4: Build the Details Screen
- [x] Milestone 5: Add Pull to Refresh
- [x] Bonus 1: Add User Profile Image and Names - instructions completely unclear
- [ ] Bonus 2: Infinite Scrolling - no api to get more
- [ ] Bonus 3: Zoomable Photo View

The following **additional** features are implemented:

- [x] send all data instead of just image url
- [x] round use profile and add border

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![instagram demo](instagram.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

* you need to use `indexpath.section` not `indexpath.row`, not explained in tutorial
* `func numberOfSectionsInTableView(tableView: UITableView) -> Int {` has to be used instead of `func tableview` blah blah... not explained in tutorial, completely random
* all the examples for arrays are not NSarrays, none of that is helpful

## License

    Copyright 2016 Julia Yu

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.