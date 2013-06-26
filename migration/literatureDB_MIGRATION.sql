# LiteratureDB Migration Script
#   
#   1. create DBSchema via Ruby on Rails
#   2. replace oldDB with the name of the old database
#   3. replace dev with the name of the new database
#   4. comment - DROP FUNCTION SPLIT_STR -
#   5. run the script and pray
#

USE dev;

DROP FUNCTION SPLIT_STR;

# CREATE FUNCTION
CREATE FUNCTION SPLIT_STR(
  x NVARCHAR(255),
  delim NVARCHAR(12),
  pos INT
)
RETURNS NVARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');

#INSERT NEW TYPES INTO THE DATABASE

DELETE FROM dev.types;

ALTER TABLE dev.types AUTO_INCREMENT = 1;

INSERT INTO dev.types (format, created_at, updated_at)
VALUES  ('book', NOW(), NOW()),
        ('generic', NOW(), NOW()),
        ('report', NOW(), NOW()),
        ('thesis', NOW(), NOW()),
        ('webpage', NOW(), NOW()),
        ('paper', NOW(), NOW()),
        ('article', NOW(), NOW()),
        ('inProceedings', NOW(), NOW());

# MIGRATE PUBLICATIONS

DELETE FROM dev.publications;

INSERT INTO dev.publications (ID, type_id, title, book_title, publisher, published_in, city, pages, year, url, keywords, abstract, doi,
                              edition, editor, journal, volume, issue, institution, date_of_last_access, type_of_work,
                              university, created_at, updated_at)
SELECT  oldDB.publications.ID, 
        (CASE oldDB.publications.type
            WHEN "Article" THEN 7
            WHEN "InProceedings" THEN 8
            WHEN "Proceedings" THEN 2
            WHEN "Book" THEN 1
            WHEN "InBook" THEN 1
            WHEN "TechReport" THEN 8
            WHEN "MastersThesis" THEN 4
            WHEN "Misc" THEN 2
            WHEN " " THEN 2
            ELSE 4
        END) AS type_id,
        IFNULL(oldDB.publications.Title,"") AS title,
        IFNULL(oldDB.publications.Booktitle, "") AS book_title,
        IFNULL(oldDB.publications.Publisher, "") AS publisher,
        IFNULL(oldDB.publications.PublishedIn, "") AS published_in,
        "",
        IFNULL(oldDB.publications.pages, "") AS pages,
        IFNULL(oldDB.publications.year, "") AS year,
        IFNULL(oldDB.publications.localURL, IFNULL(oldDB.publications.URL, "")) AS url,
        "",
        "",
        "",
        "",
        IFNULL(oldDB.publications.editor,"") AS editor,
        "",
        "",
        "",
        "",
        CURDATE(),
        "",
        "",
        NOW(),
        NOW()
FROM oldDB.publications;

# MIGRATE KNOWN AUTHORS

DELETE FROM dev.authors;

ALTER TABLE dev.authors AUTO_INCREMENT = 1;

INSERT INTO dev.authors (title, first_name, last_name, email, search_name, office, street, city, zip_code, phone, url, cv, created_at, updated_at)
SELECT  IFNULL(IF(oldDB.people.Title = "Sekret&auml;rin", "", oldDB.people.Title),"") AS title,
        IFNULL(oldDB.people.GivenName,"") AS first_name,
        IFNULL(oldDB.people.Surname,"") AS last_name,
        IFNULL(oldDB.people.Email,"") AS email,
        CONCAT( IF(oldDB.people.Title IS NULL OR oldDB.people.Title = "", "", CONCAT(oldDB.people.Title, " ")),
                oldDB.people.GivenName, " ",
                oldDB.people.Surname) AS search_name,
        IFNULL(oldDB.people.office,"") AS office,
        IFNULL(oldDB.people.street,""),
        IFNULL(oldDB.people.city,""),
        IFNULL(oldDB.people.zip,"") AS zip_code,
        IFNULL(oldDB.people.Phone,"") AS phone,
        IFNULL(oldDB.people.URL,"") AS url,
        IFNULL(oldDB.people.cv,""),
        NOW() as created_at,
        NOW() as updated_at
 FROM oldDB.people;

# MIGRATE THE AUTHORSHIPS

DELETE FROM dev.authorships;

ALTER TABLE dev.authorships AUTO_INCREMENT = 1;

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


INSERT INTO dev.authorships (publication_id, author_id, created_at, updated_at)
    SELECT  publication AS publication_id,
            (SELECT id
                FROM dev.authors
                WHERE author IN (SELECT id
                                       FROM oldDB.people
                                       WHERE Surname = last_name
                                              AND GivenName = first_name)
            ) AS author_id,
            NOW(),
            NOW()
    FROM oldDB.pub_aut
    WHERE author IN (SELECT id FROM oldDB.people) AND publication IS NOT NULL;

# INSERT UNKOWN AUTHORS

INSERT INTO dev.authors (title, first_name, last_name, email, search_name, office, street, city, zip_code, phone, url, cv, created_at, updated_at)

SELECT DISTINCT
        "",
        (CASE author
            WHEN "C. Lütke Entrup" THEN "C."
            WHEN "Filippo De Lillo" THEN "Filippo"
            WHEN "M. H. A. Bauer" THEN "M. H. A."
            WHEN "E. von Lieres" THEN "E."
            ELSE IF(SPLIT_STR(author, " ", 3) = "", # IF author can't be splitted into 3 parts
                    SPLIT_STR(author, " ", 1),     # THEN add the first part of the name
                    CONCAT(SPLIT_STR(author, " ", 1), " ", SPLIT_STR(author, " ", 2)))
        END) AS first_name,
        (CASE author
            WHEN "C. Lütke Entrup" THEN "Lütke Entrup"
            WHEN "Filippo De Lillo" THEN "De Lillo"
            WHEN "M. H. A. Bauer" THEN "Bauer"
            WHEN "E. von Lieres" THEN "von Lieres"
            ELSE IF(SPLIT_STR(author, " ", 3) = "", # IF author can't be splitted into 3 parts
                    SPLIT_STR(author, " ", 2),     # THEN add the second part of the name
                    SPLIT_STR(author, " ", 3))
        END) AS last_name, # ELSE add the third part of the name
        "",
        author AS search_name,
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        NOW(),
        NOW()
    FROM oldDB.pub_aut 
    WHERE publication IS NOT NULL AND author NOT IN (SELECT id FROM oldDB.people) AND SPLIT_STR(author, " ", 2) != "";

# INSERT AUTHORSHIPS FOR THE UNKNOWN AUTHORS

INSERT INTO dev.authorships (publication_id, author_id, created_at, updated_at)

    SELECT  publication AS publication_id,
            (SELECT id
                FROM dev.authors 
                    WHERE author = search_name
            ) AS author_id,
            NOW(),
            NOW()
    FROM oldDB.pub_aut
    WHERE publication IS NOT NULL AND author <> ALL (SELECT id FROM oldDB.people);

# SOME UPDATES ON THE AUTHOR_NAMES

#Updating given names, elemination html-encodings
UPDATE dev.authors
SET first_name = replace(first_name, "&eacute;","é");

UPDATE dev.authors
SET first_name = replace(first_name, "&ouml;","ö");

UPDATE dev.authors
SET first_name = replace(first_name, "&uuml;","ü");

#Updating surnames, elemination html-encodings
UPDATE dev.authors
SET last_name = replace(last_name, "&ouml;","ö");

UPDATE dev.authors
SET last_name = replace(last_name, "&auml;","ö");

UPDATE dev.authors
SET last_name = replace(last_name, "&uuml;","ü");

#Updating searchname column, elemination html-encodings
UPDATE dev.authors
SET search_name = replace(search_name, "&eacute;","é");

UPDATE dev.authors
SET search_name = replace(search_name, "&ouml;","ö");

UPDATE dev.authors
SET search_name = replace(search_name, "&uuml;","ü");

UPDATE dev.authors
SET search_name = replace(search_name, "&auml;","ä");

#Updating malformed mail format
UPDATE dev.authors
SET email = replace(email, "mailto:","");

#Updating publications to replace html-endcodings

# Updating the title column

UPDATE dev.publications
SET title = replace(title, "&uuml;", "ü");

UPDATE dev.publications
SET title = replace(title, "&auml;", "ä");

UPDATE dev.publications
SET title = replace(title, "&#039;", "'");

UPDATE dev.publications
SET title = replace(title, "&oacute;", "ó");

# Updating the publisher column

UPDATE dev.publications
SET publisher = replace(publisher, "&Uuml;", "Ü");


UPDATE dev.publications
SET publisher = replace(publisher, "&oacute;", "ó");


UPDATE dev.publications
SET publisher = replace(publisher, "&eacute;","é");


UPDATE dev.publications
SET publisher = replace(publisher, "&aacute;","á");

# Updating the published_in column

UPDATE dev.publications
SET published_in = replace(published_in, "&amp;","&");

UPDATE dev.publications
SET published_in = replace(published_in, "&uuml;","ü");

# Updating the editor column

UPDATE dev.publications
SET editor = replace(editor, "&Aacute;","Á");

UPDATE dev.publications
SET editor = replace(editor, "&aacute;","á");

UPDATE dev.publications
SET editor = replace(editor, "&eacute;","é");

UPDATE dev.publications
SET editor = replace(editor, "&oacute;","ó");
