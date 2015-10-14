" creates junk files with filetype
NeoBundleLazy "Shougo/junkfile.vim", {"autoload":{"commands":"JunkfileOpen","unite_sources":["junkfile","junkfile/new"]}}

let g:junkfile#directory=GetCacheDir("junk")
