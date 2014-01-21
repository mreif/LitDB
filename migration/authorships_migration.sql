DELETE FROM literatureDB.authorships;

ALTER TABLE literatureDB.authorships AUTO_INCREMENT = 1;

UPDATE oldDB.pub_aut SET author = replace(author, "B. Freisleben", "freisleb");
UPDATE oldDB.pub_aut SET author = replace(author, "Bernd Freisleben", "freisleb");
UPDATE oldDB.pub_aut SET author = replace(author, "C. Hagen", "hagen");
UPDATE oldDB.pub_aut SET author = replace(author, "B. Agel", "agel");
UPDATE oldDB.pub_aut SET author = replace(author, "D. Seiler" ,  "seiler");
UPDATE oldDB.pub_aut SET author = replace(author, "E. Papalilo" ,  "elvis");
UPDATE oldDB.pub_aut SET author = replace(author, "E. Qeli"  ,  "qeli");
UPDATE oldDB.pub_aut SET author = replace(author, "F. Thilo"  ,  "thilo");
UPDATE oldDB.pub_aut SET author = replace(author, "F. Virili" ,  "virili");
UPDATE oldDB.pub_aut SET author = replace(author, "Francesco Virili" ,  "virili");
UPDATE oldDB.pub_aut SET author = replace(author, "gllavata" ,  "glavata");
UPDATE oldDB.pub_aut SET author = replace(author, "H.J. Picht" ,  "picht");
UPDATE oldDB.pub_aut SET author = replace(author, "J. Gllavata" ,  "glavata");
UPDATE oldDB.pub_aut SET author = replace(author, "J. Wagner" ,  "wagner");
UPDATE oldDB.pub_aut SET author = replace(author, "K. Nurdan" ,  "nurdan");
UPDATE oldDB.pub_aut SET author = replace(author, "K. Ripper" ,  "ripper");
UPDATE oldDB.pub_aut SET author = replace(author, "Lars Baumgaertner" ,  "lbaumgaertner");
UPDATE oldDB.pub_aut SET author = replace(author, "Lars Baumgärtner" ,  "lbaumgaertner");
UPDATE oldDB.pub_aut SET author = replace(author, "F. Thilo"  ,  "thilo");
UPDATE oldDB.pub_aut SET author = replace(author, "F. Virili" ,  "virili");
UPDATE oldDB.pub_aut SET author = replace(author, "Francesco Virili" ,  "virili");
UPDATE oldDB.pub_aut SET author = replace(author, "gllavata" ,  "glavata");
UPDATE oldDB.pub_aut SET author = replace(author, "H.J. Picht" ,  "picht");
UPDATE oldDB.pub_aut SET author = replace(author, "J. Gllavata" ,  "glavata");
UPDATE oldDB.pub_aut SET author = replace(author, "J. Wagner" ,  "wagner");
UPDATE oldDB.pub_aut SET author = replace(author, "K. Nurdan" ,  "nurdan");
UPDATE oldDB.pub_aut SET author = replace(author, "K.Reichmann", "K. Reichmann");
UPDATE oldDB.pub_aut SET author = replace(author, "K. Ripper" ,  "ripper");
UPDATE oldDB.pub_aut SET author = replace(author, "Lars Baumgaertner" ,  "lbaumgaertner");
UPDATE oldDB.pub_aut SET author = replace(author, "Lars Baumgärtner" ,  "lbaumgaertner");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Haunschild" ,  "mdh");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Mezini" ,  "mira");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Schwalb" ,  "schwalbm");
UPDATE oldDB.pub_aut SET author = replace(author, "Martin Schwalb" ,  "schwalbm");
UPDATE oldDB.pub_aut SET author = replace(author, "M.D. Haunschild" ,  "mdh");
UPDATE oldDB.pub_aut SET author = replace(author, "Matthew Smith" ,  "matthew");
UPDATE oldDB.pub_aut SET author = replace(author, "Michael Engel" ,  "engel");
UPDATE oldDB.pub_aut SET author = replace(author, "O. Arndt" ,  "arndt");
UPDATE oldDB.pub_aut SET author = replace(author, "O. Battenfeld" ,  "odb");
UPDATE oldDB.pub_aut SET author = replace(author, "P. Reinhardt" ,  "reinharp");
UPDATE oldDB.pub_aut SET author = replace(author, "R. Sennert" ,  "sennert");
UPDATE oldDB.pub_aut SET author = replace(author, "Ralph Jansen" ,  "jr");
UPDATE oldDB.pub_aut SET author = IF(author = "roesslin", replace(author, "roesslin" ,  "roessling"), author);
UPDATE oldDB.pub_aut SET author = replace(author, "S. Herdt" ,  "sherdt");
UPDATE oldDB.people  SET id = "sherdt" where surname = "sherdt";
UPDATE oldDB.pub_aut SET author = replace(author, "S. Paal" ,  "paal");
UPDATE oldDB.pub_aut SET author = replace(author, "S. Strelen" ,  "strelen");
UPDATE oldDB.pub_aut SET author = replace(author, "Sven Hanemann" ,  "hanemann");
UPDATE oldDB.pub_aut SET author = replace(author, "T. Felzer" ,  "felzer");
UPDATE oldDB.pub_aut SET author = replace(author, "T. Stadelmann" ,  "stadelmann");
UPDATE oldDB.pub_aut SET author = replace(author, "Thilo Stadelmann" ,  "stadelmann");
UPDATE oldDB.pub_aut SET author = replace(author, "T. Unger" ,  "unger");
UPDATE oldDB.pub_aut SET author = replace(author, "Tim Dörnemann" ,  "doernemt");
UPDATE oldDB.pub_aut SET author = replace(author, "U. Kelter" ,  "kelter");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Grauer" ,  "Manfred Grauer");
UPDATE oldDB.pub_aut SET author = replace(author, "and Manfred Grauer" ,  "Manfred Grauer");
UPDATE oldDB.pub_aut SET author = replace(author, "B. Shi" ,  "Bing Shi");
UPDATE oldDB.pub_aut SET author = replace(author, "C. Kappus" ,  "Christoph Kappus");
UPDATE oldDB.pub_aut SET author = replace(author, "Ch. Nimsky" ,  "Christopher Nimsky");
UPDATE oldDB.pub_aut SET author = replace(author, "David Boeck" ,  "David Böck");
UPDATE oldDB.pub_aut SET author = replace(author, "H. Besch" , "H. J. Besch");
UPDATE oldDB.pub_aut SET author = replace(author, "H.J. Besch" ,  "H. J. Besch");
UPDATE oldDB.pub_aut SET author = replace(author, "J. P. Müller",  "Jörg P. Müller");
UPDATE oldDB.pub_aut SET author = replace(author, "J.P. Müller" ,  "Jörg P. Müller");
UPDATE oldDB.pub_aut SET author = replace(author, "K. Nöh" ,  "Katharina Nöh");
UPDATE oldDB.pub_aut SET author = replace(author, "K.S. Faszl" ,  "K. S. Faszl");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Harbach" ,  "Marian Harbach");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Heidt" ,  "Michael Heidt");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Hoof, R. Patsch" ,  "M. Hoof");
UPDATE oldDB.pub_aut SET author = replace(author, "M. Weitzel" ,  "Michael Weitzel");
UPDATE oldDB.pub_aut SET author = replace(author, "N. Pavel",  "N. A. Pavel");
UPDATE oldDB.pub_aut SET author = replace(author, "N.A. Pavel" ,  "N. A. Pavel");
UPDATE oldDB.pub_aut SET author = replace(author, "P. Brösser" ,  "P. Brössler");
UPDATE oldDB.pub_aut SET author = replace(author, "R. Kamm&uuml;ller", "Reiner Kammüller");
UPDATE oldDB.pub_aut SET author = replace(author, "R. Kammueller", "Reiner Kammüller");
UPDATE oldDB.pub_aut SET author = replace(author, "R. Kammüller", "Reiner Kammüller");
UPDATE oldDB.pub_aut SET author = replace(author, "S. Gro&szlig;kopf" ,  "S. Großkopf");
UPDATE oldDB.pub_aut SET author = replace(author, "S. Kirch" ,  "Sebastian Kirch");
UPDATE oldDB.pub_aut SET author = replace(author, "Tobias Schneider" ,  "Tobias M. Schneider");
UPDATE oldDB.pub_aut SET author = replace(author, "W. Lippe" ,  "W.-M. Lippe");
UPDATE oldDB.pub_aut SET author = replace(author, "W. Wiechert" ,  "Wolfgang Wiechert");
UPDATE oldDB.pub_aut SET author = replace(author, "akulla" ,  "Alban Kulla");
UPDATE oldDB.people SET givenname = replace(givenname, "Bj&ouml;rn" ,  "Björn");

INSERT INTO literatureDB.authorships (publication_id, author_id, created_at, updated_at, pos)
    SELECT  publication AS publication_id,
            (SELECT id
                FROM literatureDB.authors
                WHERE author IN (SELECT id
                                       FROM oldDB.people
                                       WHERE Surname = last_name
                                              AND GivenName = first_name)
            ) AS author_id,
            NOW(),
            NOW(),
            pos
    FROM oldDB.pub_aut
    WHERE author IN (SELECT id FROM oldDB.people) AND publication IS NOT NULL;

INSERT INTO literatureDB.authorships (publication_id, author_id, created_at, updated_at, pos)

    SELECT  publication AS publication_id,
            (SELECT id
                FROM literatureDB.authors 
                    WHERE author = search_name
            ) AS author_id,
            NOW(),
            NOW(),
            pos
    FROM oldDB.pub_aut
    WHERE publication IS NOT NULL AND author <> ALL (SELECT id FROM oldDB.people);
