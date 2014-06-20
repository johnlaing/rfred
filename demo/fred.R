## assumes an object f has already been set up via fred
## examples taken from http://api.stlouisfed.org/docs/fred/

## categories
fred.category(f)
fred.category(f, 125)
fred.category.children(f)
fred.category.children(f, 13)
fred.category.related(f, 32073)
fred.category.series(f, 125)
fred.category.tags(f, 125)
fred.category.related_tags(f, 125, "services;quarterly")

## releases
fred.releases(f)
fred.releases.dates(f)
fred.release(f, 53)
fred.release.dates(f, 82)
fred.release.series(f, 51)
fred.release.sources(f, 51)
fred.release.tags(f, 86)
fred.release.related_tags(f, 86, "sa;foreign")

## series
fred.series(f, "GNPCA")
fred.series.categories(f, "EXJPUS")
fred.series.observations(f, "GNPCA")
fred.series.release(f, "IRA")
fred.series.search(f, "monetary+service+index")
fred.series.search.tags(f, "monetary+service+index")
fred.series.search.related_tags(f, "mortgage+rate", "30-year")
fred.series.tags(f, "STLFSI")
fred.series.updates(f, limit=100)
fred.series.vintagedates(f, "GNPCA")

## sources
fred.sources(f)
fred.source(f, 1)
fred.source.releases(f, 1)

## tags
fred.tags(f)
fred.related_tags(f, "monetary+aggregates;weekly")
fred.tags.series(f, "slovenia;food;oecd")
