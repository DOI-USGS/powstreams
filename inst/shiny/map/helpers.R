get_types <- function(){
  meta_types = mda.streams::get_meta(types = c("basic"))
  
  names(which(sapply(meta_types, class) == 'unitted_numeric'))
}
