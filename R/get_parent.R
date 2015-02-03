get_parent = function(item_id){
  
  url <- sprintf("https://www.sciencebase.gov/catalog/item/%s?format=json&fields=parentId", item_id)

  parent_id <- fromJSON(txt = url)$parentId
  
  url <- sprintf("https://www.sciencebase.gov/catalog/item/%s?format=json&fields=title", parent_id)
  parent_site <- fromJSON(txt = url)$title
  return(parent_site)
}