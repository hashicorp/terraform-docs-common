# terraform-docs-common

Documentation for HCP Terraform and other Terraform-related documentation:

- https://developer.hashicorp.com/terraform/cloud-docs
- https://developer.hashicorp.com/terraform/plugin
- https://developer.hashicorp.com/terraform/registry

<!-- BEGIN: contributions -->
<!-- Generated text, do not edit directly -->

## Contributions Welcome!

If you find a typo or you feel like you can improve the HTML, CSS, or JavaScript, we welcome contributions. Feel free to open issues or pull requests like any normal GitHub project, and we'll merge it in 🚀

<!-- END: contributions -->

## Where the Docs Live

| Subpath                                   | Repository                   |
| :---------------------------------------- | :--------------------------- |
| [`/cdktf`][cdktf]                         | [terraform-cdk]              |
| [`/cli`][cli]                             | [terraform]                  |
| [`/cloud-docs`][cloud-docs]               | [terraform-docs-common]      |
| [`/cloud-docs/agents`][cloud-docs/agents] | [terraform-docs-agents]      |
| [`/configuration`][configuration]         | [terraform]                  |
| [`/docs`][docs]                           | [terraform]                  |
| [`/enterprise`][enterprise]               | Internal repository          |
| [`/guides`][guides]                       | [terraform]                  |
| [`/internals`][internals]                 | [terraform]                  |
| [`/intro`][intro]                         | [terraform]                  |
| [`/language`][language]                   | [terraform]                  |
| [`/plugin`][plugin]                       | [terraform-docs-common]      |
| [`/plugin/framework`][plugin/framework]   | [terraform-plugin-framework] |
| [`/plugin/log`][plugin/log]               | [terraform-plugin-log]       |
| [`/plugin/mux`][plugin/mux]               | [terraform-plugin-mux]       |
| [`/plugin/sdkv2`][plugin/sdkv2]           | [terraform-plugin-sdk]       |
| [`/registry`][registry]                   | [terraform-docs-common]      |

[cdktf]: https://www.terraform.io/cdktf
[cli]: https://www.terraform.io/cli
[cloud-docs]: https://www.terraform.io/cloud-docs
[cloud-docs/agents]: https://www.terraform.io/cloud-docs/agents
[configuration]: https://www.terraform.io/configuration
[docs]: https://www.terraform.io/docs
[enterprise]: https://www.terraform.io/enterprise
[guides]: https://www.terraform.io/guides
[internals]: https://www.terraform.io/internals
[intro]: https://www.terraform.io/intro
[language]: https://www.terraform.io/language
[plugin]: https://www.terraform.io/plugin
[plugin/framework]: https://www.terraform.io/plugin/framework
[plugin/log]: https://www.terraform.io/plugin/log
[plugin/mux]: https://www.terraform.io/plugin/mux
[plugin/sdkv2]: https://www.terraform.io/plugin/sdkv2
[registry]: https://www.terraform.io/registry
[terraform-cdk]: https://github.com/hashicorp/terraform-cdk
[terraform]: https://github.com/hashicorp/terraform
[terraform-website]: https://github.com/hashicorp/terraform-website
[terraform-docs-common]: https://github.com/hashicorp/terraform-docs-common
[terraform-docs-agents]: https://github.com/hashicorp/terraform-docs-agents
[terraform-plugin-sdk]: https://github.com/hashicorp/terraform-plugin-sdk
[terraform-plugin-log]: https://github.com/hashicorp/terraform-plugin-log
[terraform-plugin-mux]: https://github.com/hashicorp/terraform-plugin-mux
[terraform-plugin-framework]: https://github.com/hashicorp/terraform-plugin-framework

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
title: "My Title"
description: "A thorough, yet succinct description of the page's contents"
---
```

The significant keys in the YAML frontmatter are:

- `title` `(string)` - This is the title of the page that will be set in the HTML title.
- `description` `(string)` - This is a description of the page that will be set in the HTML description.

> ⚠️ If there is a need for a `/api/*` url on this website, the url will be changed to `/api-docs/*`, as the `api` folder is reserved by next.js.

### Validating Content

Content changes are automatically validated against a set of rules as part of the pull request process. If you want to run these checks locally to validate your content before committing your changes, you can run the following command:

```
npm run content-check
```

If the validation fails, actionable error messages will be displayed to help you address detected issues.

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

A number of custom [mdx components](https://mdxjs.com/) are available for use within any .mdx file. If you have questions about custom components, or have a request for a new custom component, please reach out to @hashicorp/digital-marketing.

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

## Content Images

Image files should be placed in the [`website/img`](./website/img/) directory.

In markdown, images should be referenced by their absolute path, starting with `/img`. This will look like:

```md
![Alt text goes here](/img/docs/my-image.png)
```

> **Note**: Images aren't expected to work GitHub markdown in previews, but they will work during local preview and Vercel deploy previews

<!-- BEGIN: redirects -->
<!-- Generated text, do not edit directly -->

## Redirects

This website structures URLs based on the filesystem layout. This means that if a file is moved, removed, or a folder is re-organized, links will break. If a path change is necessary, it can be mitigated using redirects. It's important to note that redirects should only be used to cover for external links -- if you are moving a path which internal links point to, the internal links should also be adjusted to point to the correct page, rather than relying on a redirect.

To add a redirect, head over to the `redirects.js` file - the format is fairly simple - there's a `source` and a `destination` - fill them both in, indicate that it's a permanent redirect or not using the `permanent` key, and that's it. Let's look at an example:

```
{
  source: '/foo',
  destination: '/bar',
  permanent: true
}
```

This redirect rule will send all incoming links to `/foo` to `/bar`. For more details on the redirects file format, [check out the docs on vercel](https://vercel.com/docs/configuration#project/redirects). All redirects will work both locally and in production exactly the same way, so feel free to test and verify your redirects locally. In the past testing redirects has required a preview deployment -- this is no longer the case. Please note however that if you add a redirect while the local server is running, you will need to restart it in order to see the effects of the redirect.

There is still one caveat though: redirects do not apply to client-side navigation. By default, all links in the navigation and docs sidebar will navigate purely on the client side, which makes navigation through the docs significantly faster, especially for those with low-end devices and/or weak internet connections. In the future, we plan to convert all internal links within docs pages to behave this way as well. This means that if there is a link on this website to a given piece of content that has changed locations in some way, we need to also _directly change existing links to the content_. This way, if a user clicks a link that navigates on the client side, or if they hit the url directly and the page renders from the server side, either one will work perfectly.

Let's look at an example. Say you have a page called `/docs/foo` which needs to be moved to `/docs/nested/foo`. Additionally, this is a page that has been around for a while and we know there are links into `/docs/foo.html` left over from our previous website structure. First, we move the page, then adjust the docs sidenav, in `data/docs-navigation.js`. Find the category the page is in, and move it into the appropriate subcategory. Next, we add to `_redirects` as such. The `.html` version is covered automatically.

```js
{ source: '/foo', destination: '/nested/foo', permanent: true }
```

Next, we run a global search for internal links to `/foo`, and make sure to adjust them to be `/nested/foo` - this is to ensure that client-side navigation still works correctly. _Adding a redirect alone is not enough_.

One more example - let's say that content is being moved to an external website. A common example is guides moving to `learn.hashicorp.com`. In this case, we take all the same steps, except that we need to make a different type of change to the `docs-navigation` file. If previously the structure looked like:

```js
{
  category: 'docs',
  content: [
    'foo'
  ]
}
```

If we no longer want the link to be in the side nav, we can simply remove it. If we do still want the link in the side nav, but pointing to an external destination, we need to slightly change the structure as such:

```js
{
  category: 'docs',
  content: [
    { title: 'Foo Title', href: 'https://learn.hashicorp.com/<product>/foo' }
  ]
}
```

As the majority of items in the side nav are internal links, the structure makes it as easy as possible to represent these links. This alternate syntax is the most concise manner than an external link can be represented. External links can be used anywhere within the docs sidenav.

It's also worth noting that it is possible to do glob-based redirects, for example matching `/docs/*`, and you may see this pattern in the redirects file. This type of redirect is much higher risk and the behavior is a bit more nuanced, so if you need to add a glob redirect, please reach out to the website maintainers and ask about it first.

<!-- END: redirects -->

## Excluding content from Terraform Enterprise

The HCP Terraform documentation is copied over to the Terraform Enterprise documentation every Terraform Enterprise release cycle. If you are adding content to the HCP Terraform documentation about a new feature, ensure you know when/if that feature is coming to Terraform Enterprise. If your new feature is _not_ coming to Terraform Enterprise in the next release, you need to _exclude_ that content from the Terraform Enterprise documentation. 

> If you are adding content exclusive to either HCP Terraform or Terraform Enterprise, refer to [our guidelines](https://github.com/hashicorp/ptfe-releases#excluding-hcp-terraform-specific-content) for guidance.

[Learn more about writing content for Terraform Enterprise](https://github.com/hashicorp/ptfe-releases#maintaining-tfe-website-documentation).