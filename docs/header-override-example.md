# CSS Override Example

This page demonstrates how the [`extra_css` MkDocs option](https://www.mkdocs.org/user-guide/customizing-your-theme/#using-the-docs_dir) can be used to customize a theme without the extra work of creating a custom theme.  First, add an `overrides` folder to your documentation folder and a new CSS file inside of that folder:

```text
my-project/
├─ docs/
│  ├─ overrides/
│  │  ├─ multi-size-headers.css
│  ├─ software/
│  │  ├─ a.md
│  │  ├─ b.md
│  ├─ about.md
├─ .gitignore
├─ mkdocs.yml
├─ README.md

```

Then add the following configuration to your `mkdocs.yml` file:
```yaml
extra_css: 
  - overrides/multi-size-headers.css
```

Include the changes you want to make in your CSS file.  
ex: `docs/overrides/multi-size-headers.css`:

```css
h1 {
    font-size: 2.2em !important;
}

h2 {
    font-size: 1.8em !important;
}

h3 {
    font-size: 1.6em !important;
}

h4 {
    font-size: 1.4em !important;
}

h5 {
    font-size: 1.2em !important;
}

h6 {
    font-size: 1em !important;
}
```

---

### Table of Contents Nesting Example
On this page **(h1) Felidae** shows up in the table of contents because it is one of the highest level sections.  

**(h2) Felinae** and **(h2) Pantherinae** show up because they are directly underneath a top level section.  

**(h3) Felis catus**, **(h3) Panthera leo**, and **(h3) Panthera tigris** do *not* display in the table of contents because they are nested at a third level (not because they use the `<h3>` header).  

Note that **(h5) Canis familiaris** shows up in the table of contents even though it uses a `<h5>` header.  This is because it is in a subsection directly underneath the top level **(h1) Canidae** section.

<hr>
<strong>Detailed TOC Example Below</strong> <span>&#11015;</span>
<hr>

# (h1) Felidae 

Felidae is the family of mammals in the order Carnivora colloquially referred to as cats.

## (h2) Felinae - (purring)
The Felinae are a subfamily of the family Felidae. This subfamily comprises the small cats having a bony hyoid, because of which they are able to purr but not roar.

### (h3) Felis catus
Domestic cats:  
- [Maine Coon](https://en.wikipedia.org/wiki/Maine_Coon)  
- [Siberian](https://en.wikipedia.org/wiki/Siberian_cat)  
- [Sphynx](https://en.wikipedia.org/wiki/Sphynx_cat)  

## (h2) Pantherinae - (roaring)
Pantherinae is a subfamily within the family Felidae.  Pantherinae species are characterised by an imperfectly ossified hyoid bone with elastic tendons that enable their larynx to be mobile.

### (h3) Panthera leo 
The lion.

### (h3) Panthera tigris 
The tiger.

# (h1) Canidae

Canidae is a biological family of dog-like carnivorans, colloquially referred to as dogs, and constitutes a clade. A member of this family is also called a canid.  There are three subfamilies found within the canid family, which are the extinct Borophaginae and Hesperocyoninae, and the extant Caninae.

##### (h5) Canis familiaris
Domestic dogs:  
- [Alaskan Husky](https://en.wikipedia.org/wiki/Alaskan_husky)  
- [Beagle](https://en.wikipedia.org/wiki/Beagle)  
- [Greyhound](https://en.wikipedia.org/wiki/Greyhound)  



