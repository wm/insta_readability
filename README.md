InstaReadability
=================

[![Build Status](https://travis-ci.org/wmernagh/insta_readability.png)](https://travis-ci.org/wmernagh/insta_readability)

Uploads bookmarks to Readability.com from an Instapaper CSV export

Installation
---

`gem install insta_readability`


Dependancies
---
You will need to have a Readability Key and Secret in a file as follows:

    ```
    # ~/.insta_readability

    api_key = 'somename'
    api_secret = 'someSHA'

    ```

You can generate your key and secret at http://www.readability.com/account/api
It will be under the _Reader API Key_ section.

Usage
---

run the following and enter your username and password when prompter:

```
insta_readability csv_file
```
