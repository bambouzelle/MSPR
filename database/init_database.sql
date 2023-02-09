PRAGMA writable_schema = 1;
delete from sqlite_master where type in ('table', 'index', 'trigger');
PRAGMA writable_schema = 0;
VACUUM;
PRAGMA INTEGRITY_CHECK;

CREATE TABLE IF NOT EXISTS person (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  nickname VARCHAR(20) NOT NULL,
  mail VARCHAR(255) NOT NULL,
  password VARCHAR(255) 
);


CREATE TABLE If NOT EXISTS reservation (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  type VARCHAR(255),
  begin_date TEXT,
  end_date TEXT,
  pricing INT,
  title VARCHAR(255),
  description TEXT,
  id_roser INT NOT NULL,
  creation_date TEXT,
  FOREIGN KEY (id_roser) REFERENCES person(id)
);

CREATE TABLE IF NOT EXISTS plant (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name VARCHAR(255),
  location VARCHAR(255),
  description VARCHAR(255),
  picture BLOB,
  sharing BOOLEAN DEFAULT FALSE,
  id_owner INT NOT NULL,
  FOREIGN Key (id_owner) REFERENCES person(id)
);

CREATE TABLE IF NOT EXISTS comment (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  description VARCHAR(255),
  rating TINYINT,
  id_owner INT NOT NULL,
  id_roser INT NOT NULL,
  FOREIGN Key (id_owner) REFERENCES person(id),
  FOREIGN Key (id_roser) REFERENCES person(id)
);


/*CREATE TABLE IF NOT EXISTS plant_info (
  id INT PRIMARY KEY NOT NULL AUTOINCREMENT,      A FAIRE EN FONCTION Du retour IA
  description VARCHAR(255),
  rating TINYINT,
  id_owner INT NOT NULL,
  id_roser INT NOT NULL,
  FOREIGN Key (id_owner) REFERENCES person(id),
  FOREIGN Key (id_roser) REFERENCES person(id)
);*/

CREATE TABLE IF NOT EXISTS plant_reservation (
  id_plant INT NOT NULL,
  id_reservation INT NOT NULL,
  PRIMARY KEY (id_plant, id_reservation),
  FOREIGN KEY (id_plant) REFERENCES plant(id),
  FOREIGN KEY (id_reservation) REFERENCES reservation(id)
);


