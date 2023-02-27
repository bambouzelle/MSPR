import sqlite3
from PIL import Image


conn = sqlite3.connect("/../../database/database.db")
cursor = conn.cursor()

cursor.execute("SELECT * FROM plant")
rows = cursor.fetchall()

for row in rows:
    im = im.open(row[0])
    width, height = im.size

    if width != 128 and height != 128:
        im_resize = im.resize((128, 128))

        cursor.execute("UPDATE plant SET picture = ? where id = ?", [im_resize, row[1]])
        conn.commit()
    else:
        im_resize = im

    if im.format != "JPEG":

        im_resize.save("", "JPEG")
        cursor.execute("UPDATE plant SET picture = ? where id = ?", [im_resize, row[1]])
        conn.commit()
    else:
        cursor.execute("UPDATE plant SET picture = ? where id = ?", [im_resize, row[1]])
        conn.commit()

conn.close()


    


        