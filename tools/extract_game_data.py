import json
import os

def extract_sprites():
    with open('extracted_jar/r', 'rb') as f:
        r_data = f.read()

    entries = [
        (1, 0, 1176, 'aa.png'),
        (2, 1176, 264, 'ab.png'),
        (3, 1440, 372, 'ac.png'),
        (4, 1812, 216, 'ad.png'),
        (5, 2028, 1572, 'ae.png'),
        (6, 3600, 24, 'af.png'),
        (7, 3624, 24, 'ag.png'),
        (8, 3648, 36, 'ah.png'),
    ]

    sprites = {}
    for img_idx, off, sz, img_name in entries:
        chunk = r_data[off:off+sz]
        start_id = int.from_bytes(chunk[0:2], 'big')
        end_id = int.from_bytes(chunk[2:4], 'big')
        p = 4
        for sid in range(start_id, end_id):
            sx = int.from_bytes(chunk[p:p+2], 'big', signed=True); p += 2
            sy = int.from_bytes(chunk[p:p+2], 'big', signed=True); p += 2
            w = int.from_bytes(chunk[p:p+2], 'big', signed=True); p += 2
            h = int.from_bytes(chunk[p:p+2], 'big', signed=True); p += 2
            ax = int.from_bytes(chunk[p:p+2], 'big', signed=True); p += 2
            ay = int.from_bytes(chunk[p:p+2], 'big', signed=True); p += 2
            sprites[sid] = {
                'id': sid,
                'image': img_name,
                'imageIdx': img_idx,
                'srcX': sx,
                'srcY': sy,
                'width': w,
                'height': h,
                'anchorX': ax,
                'anchorY': ay,
            }

    with open('assets/data/sprites.json', 'w') as out:
        json.dump(sprites, out, indent=2)
    print(f"Extracted {len(sprites)} sprites to assets/data/sprites.json")


def extract_strings():
    with open('extracted_jar/l', 'rb') as f:
        data = f.read()

    import io
    stream = io.BytesIO(data)
    for i in range(7):
        slen = int.from_bytes(stream.read(2), 'big')
        name = stream.read(slen).decode('utf-8')
        skip = int.from_bytes(stream.read(4), 'big')

    strings_en = []
    for i in range(205):
        slen = int.from_bytes(stream.read(2), 'big')
        s = stream.read(slen).decode('utf-8', errors='replace')
        strings_en.append(s)

    with open('assets/data/strings_en.json', 'w', encoding='utf-8') as out:
        json.dump(strings_en, out, indent=2, ensure_ascii=False)
    print(f"Extracted {len(strings_en)} English strings to assets/data/strings_en.json")


def extract_level_0():
    with open('extracted_jar/aj.bin', 'rb') as f:
        byArray = f.read()

    n3 = 0
    n3 += 1
    z = byArray[0]
    tile_types = []
    for n7 in range(z):
        P = byArray[n3]; n3 += 1
        Q = byArray[n3]; n3 += 1
        O = byArray[n3]; n3 += 1
        N = byArray[n3]; n3 += 1
        g_flag = byArray[n3] != 0; n3 += 1
        e_val = (byArray[n3] << 8) | byArray[n3+1]; n3 += 2
        tile_types.append({
            'index': n7,
            'isSolid': not g_flag,
            'eVal': e_val,
        })

    n8 = byArray[n3]; n3 += 1
    n6 = byArray[n3]; n3 += 1
    B_val = n6 + 1
    translation_table = {}
    for n7 in range(n8):
        n5 = byArray[n3]; n3 += 1
        n4 = byArray[n3]; n3 += 1
        translation_table[n5] = n4

    level_len = (byArray[n3] << 8) | byArray[n3+1]; n3 += 2
    g_prop = byArray[n3]; n3 += 1
    h_prop = byArray[n3]; n3 += 1
    map_w = byArray[n3]; n3 += 1
    map_h = byArray[n3]; n3 += 1

    tile_grid = []
    for n7 in range(map_w * map_h):
        tile_grid.append(byArray[n3])
        n3 += 1

    v_entities = byArray[n3]; n3 += 1
    entities = []
    for n7 in range(v_entities):
        etype = byArray[n3]; n3 += 1
        y_val = byArray[n3]; n3 += 1
        b_val = 2 if byArray[n3] == 0 else 0; n3 += 1
        n_wp = byArray[n3]; n3 += 1
        waypoints = []
        for n5 in range(n_wp):
            wp = {
                'gridX': byArray[n3],
                'gridY': byArray[n3+1],
                'waitTime': byArray[n3+2],
                'direction': byArray[n3+3],
            }
            waypoints.append(wp)
            n3 += 4
        entities.append({
            'index': n7,
            'entityType': etype,
            'yVal': y_val,
            'initialX': waypoints[0]['gridX'],
            'initialY': waypoints[0]['gridY'],
            'waypoints': waypoints,
        })

    # Read composite tile definitions if present at end of level data
    # (n6, j table)
    level_data = {
        'levelIndex': 0,
        'name': 'The Snow Relay',
        'subtitle': 'Ramon wakes up',
        'width': map_w,
        'height': map_h,
        'tileSize': 10,
        'compositeBase': B_val,
        'tiles': tile_grid,
        'tileTypes': tile_types,
        'entities': entities,
    }

    with open('assets/data/level_0.json', 'w') as out:
        json.dump(level_data, out, indent=2)
    print(f"Extracted Level 0 ({map_w}x{map_h}, {len(entities)} entities) to assets/data/level_0.json")


if __name__ == '__main__':
    extract_sprites()
    extract_strings()
    extract_level_0()
