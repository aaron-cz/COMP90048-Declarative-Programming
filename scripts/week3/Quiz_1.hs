-- Quiz 1
data PubFreq = Days Int| Months Int
data LibraryItem = Book Int String String| Periodical Int String PubFreq

-- Getting the title
title :: LibraryItem -> String

title (Book _ t _) = t
title (Periodical _ t _) = t