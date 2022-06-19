---
title: "Hugo cheatsheet"
date: 2022-06-19T14:43:47+00:00
publishDate: 2022-06-18T14:43:47+00:00
draft: false
github_link: "https://github.com/pokusio/npx-hugo-gmented"
author: "Jean-B. Lasselle"
tags:
  - TypeScript
  - npx
  - hugo
  - cheatsheet
image: /images/posts/typescript/Typescript_logo_2020.svg
description: ""
toc:
---

## What you will find here

Every time I learn something useful about `hugo`, and I want to remember it, I add another paragraph here.

Oh, you never heard about Hugo ? go visit https://gohugo.io !! :dash:

##  Howtos ToC

### Change depth of ToC

https://github.com/alex-shpak/hugo-book/issues/52#issuecomment-599609898


```Yaml
#... A lot of configuration before

# --- here the top Level configuration
#     element 'markdown' is the one we
#     use to configure ToC level
markup:
  # just to set ToC depth
  tableOfContents:
    endLevel: 4
    startLevel: 2
    # ordered: false
#... A lot of confiugration after
```


### Hugo, dates, and Time

Well `hugo` has a lot of work and no time to get some date with _huguette_...

Everything about Dates and time in hugo projects' here.

#### Generating a hugo date string

I'll show you how to do that using a docker container, so that you can run this operation anywhere you can run a docker container.


I know of two formats that are going to be accepted as valid by `hugo` as a `date` (in the frontmatter) for a post :

```bash

docker pull debian

docker run -itd --restart unless-stopped --name deb_util debian bash


# export DATE_CMD_WITH_TIMEZONE_SHIFT="date -u +'%Y-%m-%dT%H:%M:%S%:z'"
# export DATE_CMD_WITHOUT_TIMEZONE="date -u +'%Y-%m-%dT%H:%M:%S%'"

export DATE_CMD_WITH_TZ_NOW="date -u +'%Y-%m-%dT%H:%M:%S%:z'"

export DATE_CMD_WITH_TZ_NOW_PLUS_ONE_DAY="date -u +'%Y-%m-%dT%H:%M:%S%:z' -d '+1 days'"

docker exec -it deb_util bash -c "${DATE_CMD_WITH_TZ_NOW}"

docker exec -it deb_util bash -c "${DATE_CMD_WITH_TZ_NOW_PLUS_ONE_DAY}"

```

#### Return to the Future Hugo

In the frontmatter of a `hugo` post, you can set two different date times :

* the post `date` : that's the date the user will see as date the post was written
* the post `publishDate` : that's a very interesting one, just test the example below, you'll understand!

First, generate two datetime string, the current date time, and the current datetime plus exactly 24 hours :

```bash

docker pull debian

docker run -itd --restart unless-stopped --name deb_util debian bash


export DATE_CMD_WITH_TZ_NOW="date -u +'%Y-%m-%dT%H:%M:%S%:z'"

export DATE_CMD_WITH_TZ_NOW_PLUS_ONE_DAY="date -u +'%Y-%m-%dT%H:%M:%S%:z' -d '+1 days'"

docker exec -it deb_util bash -c "${DATE_CMD_WITH_TZ_NOW}"

docker exec -it deb_util bash -c "${DATE_CMD_WITH_TZ_NOW_PLUS_ONE_DAY}"

export DATE_NOW=$(docker exec -it deb_util bash -c "${DATE_CMD_WITH_TZ_NOW}" | tr -d "\n\r")

export DATE_NOW_PLUS_ONE_DAY=$(docker exec -it deb_util bash -c "${DATE_CMD_WITH_TZ_NOW_PLUS_ONE_DAY}" | tr -d "\n\r")

echo "# ----------------- ----------------- ----------------- #"
echo ""
echo "DATE_NOW=[${DATE_NOW}]"
echo ""
echo "DATE_NOW_PLUS_ONE_DAY=[${DATE_NOW_PLUS_ONE_DAY}]"
echo "# ----------------- ----------------- ----------------- #"

```


Now create a new post in your `hugo` project, and in the front matter set :

* The `date`, to the value you generated and stored into the `DATE_NOW_PLUS_ONE_DAY` environment variable above.
* The `publishDate`, to the value you generated and stored into the `DATE_NOW` environment variable above.


In your new post, the front matter will look like :


```Markdown
---
title: "My Awesome new hugo post!"
date: 2022-06-19T00:21:05+00:00
publishDate: 2022-06-20T00:21:05+00:00
draft: false
github_link: "https://github.com/pokusio/npx-hugo-gmented"
author: "H.P. Lovecraft"
tags:
  - Awesome Books
  - incredible writer
  - american
  - mystical
  - lovecraft
  - mythology
image: /images/posts/hplovecraft/callofcthulhu.svg
description: ""
toc:
---

```

Finally, for both new posts, in your rendered HTML layout, _(for example a `single.html` layout for the `hugo` content type of your post)_, you must at least render the `{{ .Params.date.Format "Monday, Jan 2, 2006" }}` field, for example next to post author, like this :

```Html
<div class="text-center">
  {{ .Params.author }}
  <small>|</small>
  {{ .Params.date.Format "Monday, Jan 2, 2006" }}
</div>
```

>
> Now run your hugo server locally :
> * Okay, you have a new post,
> * your new post has `DATE_CMD_WITH_TZ_NOW_PLUS_ONE_DAY` as publishing date
> * your new post is dated in the future, but yet is already published :
>   * the `publishDate` tells hugo when to actually publish the article
>   * Every time the `hugo` build is executed, hugo will compare the `publishDate` and the current date time, and if the `publishDate` is is the past, `hugo` will actually build the post.
>   * When you do not set the `publishDate`, `hugo` will default its value, to the value of the `date` in the front matter.
>   * This means a `hugo` post in the future basivcally will not be built until current system date time is beyond in time
>


## References


* https://www.typescriptlang.org/docs/handbook/classes.html
* https://www.typescriptlang.org/docs/handbook/interfaces.html
