function repeat(str, nf){
    i = 1;
    rep = "";
    while(i++ < nf)
	rep = rep str;
    return rep;
}


# Need to process 1 line ahead of my intentions!
BEGIN {
    FS="/"
    nfp = 0;
    nfc = 0;
    nfn = 0;
    jsonSet = "{\"min\":\"0\",\"max\":\"500\"}"
}

#print repeat("\t", nfc)",\""nfcv"\"" " : "jsonSet
#print repeat("\t", nfc)"}\n"repeat("\t", nfc)",\"" nfcv "\"" " : " jsonSet;
#print repeat("\t", nfc)"}\n"repeat("\t", nfc)",\"" nfcv "\"" #" : " jsonSet;

/.*/ {
    if ( nfp == nfc ) { # sibling of previous
	if ( nfn == nfc ) { # sibling of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : ss"; #,key : value

	} else if (nfn > nfc ) { # parent of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : sp"; #,key : value

	} else { # child of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : sc"; #,key : value

	}
    } else if ( nfp > nfc ) { # child of previous
	if ( nfn == nfc ) { # sibling of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : cs"; #,key : value

	} else if (nfn > nfc ) { # parent of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : cp"; #,key : value

	} else { # child of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : cc"; #,key : value

	}
    } else { # parent of previous
	if ( nfn == nfc ) { # sibling of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : ps"; #,key : value

	} else if (nfn > nfc ) { # parent of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : pp"; #,key : value

	} else { # child of next

	    print repeat("\t", nfc)",\""nfcv"\"" " : pc"; #,key : value

	}
    }
    nfp = nfc;
    nfc = nfn;
    nfn = NF;
    nfcv = nfnv;
    nfnv = $NF;
}