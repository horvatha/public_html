# encoding: utf-8

fejlec = """<html>
<head>
<title>Adatbázis-lekérdezések</title>
<link REL="stylesheet" TYPE="text/css"
href="http://django.arek.uni-obuda.hu/segedletek/stilus/stilus.css">
</head>
<body>
"""

def htmltabla(elemek, oszlopok_szama=None, fejlec=None, colgroup=False):
    """HTML-táblázatot csinál az elemekből.

    Ha az oszlopok száma nincs megadva, akkor a 0. elem hosszából határozza meg.
    Jó például listák listájánál, ahol minden elem egyforma hosszú. Akkor
    minden belső lista új sorban lesz.

    Ha egy hosszú listám van, akkor a megadott oszlopszám szerint töri sorokba.
    Jó például, ha képekből akarok galériát csinálni.

    Minden elemet ami http kezdetű és jpg vagy png vagy jpeg vagy gif végű
    (eltekintve a kis-nagy betűktől) képhivatkozássá alakít.

    A részleteit nem kell kell érteni, használni kell."""
    if isinstance(elemek[0], (list, tuple)):
        if oszlopok_szama is None:
            oszlopok_szama = len(elemek[0])

        lista = []
        for sor in elemek:
            lista.extend(sor) # Egyetlen hosszú listává rakja össze a eredményt.
        elemek = lista

    sorok = []
    sorok.append('''<table width="100%" border=1>''')
    if colgroup:
        sorok.append('''    <colgroup span=%d width=%d%%>
    </colgroup>
 <tr> ''' % (oszlopok_szama, 100//oszlopok_szama))

    if type(fejlec) == type([]) and len(fejlec) == oszlopok_szama:
        for elemm in fejlec:
            sorok.append("   <th>%s</th>" % elemm)
    sorok.append(" </tr>\n <tr>")

    elemsorszam = 1
    for elem in elemek:
        elemm = elem
        if elemm in [None,""]:
            elemm='&nbsp;'
        if type(elemm) == type("") and elemm.startswith("http"):
            elemlower = elem.lower()
            if elemlower.endswith("png") or  elemlower.endswith("jpg") or elemlower.endswith("jpeg") or elemlower.endswith("gif"):
                elemm = '<img src="%s">' % elemm
        sorok.append("   <td>%s</td>" % elemm)
        if elemsorszam % oszlopok_szama == 0:
            sorok.append(" </tr>\n <tr>")
        elemsorszam += 1
    sorok.append(" </tr>\n</table>\n")
    return sorok

def attr_names(table, connection):
    cursor = connection.cursor()
    cursor.execute("""
    SELECT attname
    FROM pg_catalog.pg_attribute
     WHERE attrelid = (SELECT c.oid FROM pg_catalog.pg_class AS c WHERE
     c.relname ~ '^(%s)$')
     AND attnum > 0 AND NOT attisdropped
    ORDER BY attnum;""" % table)
    attr = [l[0] for l in cursor.fetchall()]
    return attr

def html(table, connection):
    print '<h2>%s tábla</h2>' % table
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM %s;" % table)
    eredmeny = cursor.fetchall()
    return "\n".join(htmltabla(eredmeny, fejlec=attr_names(table, connection)))

