# terraform-docs-common
Content for Terraform's documentation.

- https://terraform.io/cloud-docs
- https://terraform.io/plugin
- https://terraform.io/registry

## Running the Site Locally

### Using Docker

If you wish to run the site in a container, you can run the site locally via
`make`.

- `make website`
  - This command will pull and run the latest website container.
  - This includes live reload which will load your changes as you make them.
- `make website/local`
  - This command will run the website locally using a locally built image
  - This includes live reload which will load your changes as you make them.
- `make website/build-local`
  - This command will build a local image of the website from `hashicorp/dev-portal.git`.

...and then visit `http://localhost:3000`.
There's no need to re-run `make website` each time the site is run, only the
first time.

<!-- BEGIN: editing-markdown -->
<!-- Generated text, do not edit directly -->

## Editing Markdown Content

Documentation content is written in [Markdown](https://www.markdownguide.org/cheat-sheet/) and you'll find all files listed under the `/content` directory.

To create a new page with Markdown, create a file ending in `.mdx` in a `website/docs/<subdirectory>`. The path in the content directory will be the URL route. For example, `website/docs/docs/hello.mdx` will be served from the `/docs/hello` URL.

> **Important**: Files and directories will only be rendered and published to the website if they are [included in sidebar data](#editing-navigation-sidebars). Any file not included in sidebar data will not be rendered or published.

This file can be standard Markdown and also supports [YAML frontmatter](https://middlemanapp.com/basics/frontmatter/). YAML frontmatter is optional, there are defaults for all keys.

```yaml
---
title: 'My Title'
description: "A thorough, yet succinct description of the page's contents"
---

```

The significant keys in the YAML frontmatter are:

- `title` `(string)` - This is the title of the page that will be set in the HTML title.
- `description` `(string)` - This is a description of the page that will be set in the HTML description.

> ⚠️ If there is a need for a `/api/*` url on this website, the url will be changed to `/api-docs/*`, as the `api` folder is reserved by next.js.

### Creating New Pages

There is currently a small bug with new page creation - if you create a new page and link it up via subnav data while the server is running, it will report an error saying the page was not found. This can be resolved by restarting the server.

### Markdown Enhancements

There are several custom markdown plugins that are available by default that enhance [standard markdown](https://commonmark.org/) to fit our use cases. This set of plugins introduces a couple instances of custom syntax, and a couple specific pitfalls that are not present by default with markdown, detailed below:

- If you see the symbols `~>`, `->`, `=>`, or `!>`, these represent [custom alerts](https://github.com/hashicorp/remark-plugins/tree/master/plugins/paragraph-custom-alerts#paragraph-custom-alerts). These render as colored boxes to draw the user's attention to some type of aside.
- If you see `@include '/some/path.mdx'`, this is a [markdown include](https://github.com/hashicorp/remark-plugins/tree/master/plugins/include-markdown#include-markdown-plugin). It's worth noting as well that all includes resolve from `website/content/partials` by default, and that changes to partials will not live-reload the website.
- If you see `# Headline ((#slug))`, this is an example of an [anchor link alias](https://github.com/hashicorp/remark-plugins/tree/je.anchor-link-adjustments/plugins/anchor-links#anchor-link-aliases). It adds an extra permalink to a headline for compatibility and is removed from the output.
- Due to [automatically generated permalinks](https://github.com/hashicorp/remark-plugins/tree/je.anchor-link-adjustments/plugins/anchor-links#anchor-links), any text changes to _headlines_ or _list items that begin with inline code_ can and will break existing permalinks. Be very cautious when changing either of these two text items.

  Headlines are fairly self-explanatory, but here's an example of how to list items that begin with inline code look.

  ```markdown
  - this is a normal list item
  - `this` is a list item that begins with inline code
  ```

  Its worth noting that _only the inline code at the beginning of the list item_ will cause problems if changed. So if you changed the above markup to...

  ```markdown
  - lsdhfhksdjf
  - `this` jsdhfkdsjhkdsfjh
  ```

  ...while it perhaps would not be an improved user experience, no links would break because of it. The best approach is to **avoid changing headlines and inline code at the start of a list item**. If you must change one of these items, make sure to tag someone from the digital marketing development team on your pull request, they will help to ensure as much compatibility as possible.

### Custom Components

A number of custom [mdx components](https://mdxjs.com/) are available for use within any `.mdx` file. Each one is documented below:

#### Tabs

The `Tabs` component creates tabbed content of any type, but is often used for code examples given in different languages. Here's an example of how it looks from the Vagrant documentation website:

![Tabs Component](https://p176.p0.n0.cdn.getcloudapp.com/items/WnubALZ4/Screen%20Recording%202020-06-11%20at%2006.03%20PM.gif?v=1de81ea720a8cc8ade83ca64fb0b9edd)

> Please refer to the [Swingset](https://react-components.vercel.app/?component=Tabs) documention for the latest examples and API reference.

It can be used as such within a markdown file:

````mdx
Normal **markdown** content.

<Tabs>
<Tab heading="CLI command">
            <!-- Intentionally skipped line.. -->
```shell-session
$ command ...
```
            <!-- Intentionally skipped line.. -->
</Tab>
<Tab heading="API call using cURL">

```shell-session
$ curl ...
```

</Tab>
</Tabs>

Continued normal markdown content
````

The intentionally skipped line is a limitation of the mdx parser which is being actively worked on. All tabs must have a heading, and there is no limit to the number of tabs, though it is recommended to go for a maximum of three or four.

#### Enterprise Alert

This component provides a standard way to call out functionality as being present only in the enterprise version of the software. It can be presented in two contexts, inline or standalone. Here's an example of standalone usage from the Consul docs website:

![Enterprise Alert Component - Standalone](https://p176.p0.n0.cdn.getcloudapp.com/items/WnubALp8/Screen%20Shot%202020-06-11%20at%206.06.03%20PM.png?v=d1505b90bdcbde6ed664831a885ea5fb)

The standalone component can be used as such in markdown files:

```mdx
# Page Headline

<EnterpriseAlert />

Continued markdown content...
```

It can also receive custom text contents if you need to change the messaging but wish to retain the style. This will replace the text `This feature is available in all versions of Consul Enterprise.` with whatever you add. For example:

```mdx
# Page Headline

<EnterpriseAlert>
  My custom text here, and <a href="#">a link</a>!
</EnterpriseAlert>

Continued markdown content...
```

It's important to note that once you are adding custom content, it must be html and can not be markdown, as demonstrated above with the link.

Now let's look at inline usage, here's an example:

![Enterprise Alert Component - Inline](https://p176.p0.n0.cdn.getcloudapp.com/items/L1upYLEJ/Screen%20Shot%202020-06-11%20at%206.07.50%20PM.png?v=013ba439263de8292befbc851d31dd78)

And here's how it could be used in your markdown document:

```mdx
### Some Enterprise Feature <EnterpriseAlert inline />

Continued markdown content...
```

It's also worth noting that this component will automatically adjust to the correct product colors depending on the context.

#### Other Components

Other custom components can be made available on a per-site basis, the above are the standards. If you have questions about custom components that are not documented here, or have a request for a new custom component, please reach out to @hashicorp/digital-marketing.

### Syntax Highlighting

When using fenced code blocks, the recommendation is to tag the code block with a language so that it can be syntax highlighted. For example:

````
```
// BAD: Code block with no language tag
```

```javascript
// GOOD: Code block with a language tag
```
````

Check out the [supported languages list](https://prismjs.com/#supported-languages) for the syntax highlighter we use if you want to double check the language name.

It is also worth noting specifically that if you are using a code block that is an example of a terminal command, the correct language tag is `shell-session`. For example:

🚫**BAD**: Using `shell`, `sh`, `bash`, or `plaintext` to represent a terminal command

````
```shell
$ terraform apply
```
````

✅**GOOD**: Using `shell-session` to represent a terminal command

````
```shell-session
$ terraform apply
```
````

<!-- END: editing-markdown -->

<!-- BEGIN: editing-docs-sidebars -->
<!-- Generated text, do not edit directly -->

## Editing Navigation Sidebars

The structure of the sidebars are controlled by files in the [`/data` directory](data). For example, [data/docs-nav-data.json](data/docs-nav-data.json) controls the **docs** sidebar. Within the `data` folder, any file with `-nav-data` after it controls the navigation for the given section.

The sidebar uses a simple recursive data structure to represent _files_ and _directories_. The sidebar is meant to reflect the structure of the docs within the filesystem while also allowing custom ordering. Let's look at an example. First, here's our example folder structure:

```text
.
├── docs
│   └── directory
│       ├── index.mdx
│       ├── file.mdx
│       ├── another-file.mdx
│       └── nested-directory
│           ├── index.mdx
│           └── nested-file.mdx
```

Here's how this folder structure could be represented as a sidebar navigation, in this example it would be the file `website/data/docs-nav-data.json`:

```json
[
  {
    "title": "Directory",
    "routes": [
      {
        "title": "Overview",
        "path": "directory"
      },
      {
        "title": "File",
        "path": "directory/file"
      },
      {
        "title": "Another File",
        "path": "directory/another-file"
      },
      {
        "title": "Nested Directory",
        "routes": [
          {
            "title": "Overview",
            "path": "directory/nested-directory"
          },
          {
            "title": "Nested File",
            "path": "directory/nested-directory/nested-file"
          }
        ]
      }
    ]
  }
]
```

A couple more important notes:

- Within this data structure, ordering is flexible, but hierarchy is not. The structure of the sidebar must correspond to the structure of the content directory. So while you could put `file` and `another-file` in any order in the sidebar, or even leave one or both of them out, you could not decide to un-nest the `nested-directory` object without also un-nesting it in the filesystem.
- The `title` property on each node in the `nav-data` tree is the human-readable name in the navigation.
- The `path` property on each leaf node in the `nav-data` tree is the URL path where the `.mdx` document will be rendered, and the
- Note that "index" files must be explicitly added. These will be automatically resolved, so the `path` value should be, as above, `directory` rather than `directory/index`. A common convention is to set the `title` of an "index" node to be `"Overview"`.

Below we will discuss a couple of more unusual but still helpful patterns.

### Index-less Categories

Sometimes you may want to include a category but not have a need for an index page for the category. This can be accomplished, but as with other branch and leaf nodes, a human-readable `title` needs to be set manually. Here's an example of how an index-less category might look:

```text
.
├── docs
│   └── indexless-category
│       └── file.mdx
```

```json
// website/data/docs-nav-data.json
[
  {
    "title": "Indexless Category",
    "routes": [
      {
        "title": "File",
        "path": "indexless-category/file"
      }
    ]
  }
]
```

### Custom or External Links

Sometimes you may have a need to include a link that is not directly to a file within the docs hierarchy. This can also be supported using a different pattern. For example:

```json
[
  {
    "name": "Directory",
    "routes": [
      {
        "title": "File",
        "path": "directory/file"
      },
      {
        "title": "Another File",
        "path": "directory/another-file"
      },
      {
        "title": "Tao of HashiCorp",
        "href": "https://www.hashicorp.com/tao-of-hashicorp"
      }
    ]
  }
]
```

If the link provided in the `href` property is external, it will display a small icon indicating this. If it's internal, it will appear the same way as any other direct file link.

<!-- END: editing-docs-sidebars -->

## Editing Navigation Sidebars

The structure of the sidebars are controlled by files in the [`/data` directory](data). For example, [data/docs-nav-data.json](data/docs-nav-data.json) controls the **docs** sidebar. Within the `data` folder, any file with `-nav-data` after it controls the navigation for the given section.

The sidebar uses a simple recursive data structure to represent _files_ and _directories_. The sidebar is meant to reflect the structure of the docs within the filesystem while also allowing custom ordering. Let's look at an example. First, here's our example folder structure:

```text
.
├── docs
│   └── directory
│       ├── index.mdx
│       ├── file.mdx
│       ├── another-file.mdx
│       └── nested-directory
│           ├── index.mdx
│           └── nested-file.mdx
```

Here's how this folder structure could be represented as a sidebar navigation, in this example it would be the file `website/data/docs-nav-data.json`:

```json
[
  {
    "title": "Directory",
    "routes": [
      {
        "title": "Overview",
        "path": "directory"
      },
      {
        "title": "File",
        "path": "directory/file"
      },
      {
        "title": "Another File",
        "path": "directory/another-file"
      },
      {
        "title": "Nested Directory",
        "routes": [
          {
            "title": "Overview",
            "path": "directory/nested-directory"
          },
          {
            "title": "Nested File",
            "path": "directory/nested-directory/nested-file"
          }
        ]
      }
    ]
  }
]
```

A couple more important notes:

- Within this data structure, ordering is flexible, but hierarchy is not. The structure of the sidebar must correspond to the structure of the content directory. So while you could put `file` and `another-file` in any order in the sidebar, or even leave one or both of them out, you could not decide to un-nest the `nested-directory` object without also un-nesting it in the filesystem.
- The `title` property on each node in the `nav-data` tree is the human-readable name in the navigation.
- The `path` property on each leaf node in the `nav-data` tree is the URL path where the `.mdx` document will be rendered, and the
- Note that "index" files must be explicitly added. These will be automatically resolved, so the `path` value should be, as above, `directory` rather than `directory/index`. A common convention is to set the `title` of an "index" node to be `"Overview"`.

Below we will discuss a couple of more unusual but still helpful patterns.

### Index-less Categories

Sometimes you may want to include a category but not have a need for an index page for the category. This can be accomplished, but as with other branch and leaf nodes, a human-readable `title` needs to be set manually. Here's an example of how an index-less category might look:

```text
.
├── docs
│   └── indexless-category
│       └── file.mdx
```

```json
// website/data/docs-nav-data.json
[
  {
    "title": "Indexless Category",
    "routes": [
      {
        "title": "File",
        "path": "indexless-category/file"
      }
    ]
  }
]
```

### Custom or External Links

Sometimes you may have a need to include a link that is not directly to a file within the docs hierarchy. This can also be supported using a different pattern. For example:

```json
[
  {
    "name": "Directory",
    "routes": [
      {
        "title": "File",
        "path": "directory/file"
      },
      {
        "title": "Another File",
        "path": "directory/another-file"
      },
      {
        "title": "Tao of HashiCorp",
        "href": "https://www.hashicorp.com/tao-of-hashicorp"
      }
    ]
  }
]
```

If the link provided in the `href` property is external, it will display a small icon indicating this. If it's internal, it will appear the same way as any other direct file link.

<!-- END: editing-docs-sidebars -->

## Content Images

Image files should be placed in the [`website/img`](./website/img/) directory.

In markdown, images should be referenced by their absolute path, starting with `/img`. This will look like:

```md
![Alt text goes here](/img/docs/my-image.png)
```

> **Note**: Images aren't expected to work GitHub markdown in previews, but they will work during local preview and Vercel deploy previews

## Redirects

For now, redirects will need to be handled here: https://github.com/hashicorp/terraform-website/blob/master/redirects.next.js