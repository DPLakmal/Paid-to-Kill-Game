/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Font
 *  javax.microedition.lcdui.Graphics
 */
import javax.microedition.lcdui.Font;
import javax.microedition.lcdui.Graphics;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class l
extends n {
    private final int f = e.a;
    private final int g = e.e;
    private c[] a;
    private n a;
    private boolean a;
    public final int a;
    public final int e;
    private int h;
    private int i;
    private int j = 0;
    private final int k;
    private boolean b = false;

    public l(c[] cArray, int n2, n n3, String string) {
        int n4;
        int n5;
        int n6;
        this.a = null;
        this.a = false;
        int n7 = 0;
        for (n6 = 0; n6 < cArray.length; ++n6) {
            if (n7 >= cArray[n6].b) continue;
            n7 = cArray[n6].b;
        }
        n6 = 0;
        for (n5 = 0; n5 < cArray.length; ++n5) {
            n6 += cArray[n5].c + 2;
        }
        n6 -= 2;
        Font font = Font.getFont((int)32, (int)0, (int)0);
        n5 = font.getHeight() + 4;
        if (n2 + 8 > n.c - n5 * 2) {
            n2 = n.c - n5 * 2 - 8;
        }
        this.a = n3;
        this.a = cArray;
        this.a = n2;
        this.e = n7;
        this.h = 0;
        this.i = n2;
        int n8 = this.f != -1 ? b.a(this.f, 3) + 2 : 0;
        int n9 = n4 = this.g != -1 ? b.a(this.g, 3) + 2 : 0;
        if (n6 > this.i) {
            this.h += n8;
            this.i -= n8 + n4;
            this.k = n6 - this.i;
        } else {
            this.k = 0;
        }
        if (string != null) {
            this.a(string, 0);
            this.b = true;
        }
    }

    public final void b() {
        if (this.j + 20 > this.k) {
            this.j = this.k;
            return;
        }
        this.j += 20;
    }

    public final void c() {
        if (this.j - 20 < 0) {
            this.j = 0;
            return;
        }
        this.j -= 20;
    }

    public final void b(int n2) {
        switch (n2) {
            case 1: {
                this.c();
                return;
            }
            case 2: {
                this.b();
                return;
            }
            case 5: 
            case 7: 
            case 15: {
                if (n2 == 6 && !this.b) {
                    return;
                }
                if (this.a == null) break;
                this.j = 0;
                h.a(this.a);
            }
        }
    }

    public final void a() {
        if (this.a != null) {
            this.a = false;
        }
    }

    public final void a(Graphics graphics, int n2, int n3) {
        int n4;
        int n5;
        graphics.setClip(n2, n3, this.e, this.a);
        if (this.k > 0) {
            if (this.f != -1 && this.j > 0) {
                n5 = n2 + (this.e >> 1) + b.a(this.f, 4) - (b.a(this.f, 2) >> 1);
                n4 = n3 + b.a(this.f, 5);
                b.a(n5, n4, this.f, graphics);
            }
            if (this.g != -1 && this.j < this.k) {
                n5 = n2 + (this.e >> 1) + b.a(this.g, 4) - (b.a(this.g, 2) >> 1);
                n4 = n3 + this.a - b.a(this.g, 5) - b.a(this.g, 3);
                b.a(n5, n4, this.g, graphics);
            }
        }
        graphics.setClip(n2, n3 + this.h, this.e, this.i);
        n5 = n3 + this.h;
        for (int i = 0; i < this.a.length; ++i) {
            n4 = (this.a[i].a & 2) != 0 ? n2 + (this.e - this.a[i].b >> 1) : n2;
            this.a[i].a(graphics, n4, n5 - this.j);
            n5 += this.a[i].c + 2;
        }
    }

    public final void a(Graphics graphics) {
        if (this.a != null && !this.a) {
            this.a.a(graphics);
            this.a = true;
        }
        int n2 = (n.b - this.e >> 1) - 4;
        int n3 = (n.c - this.a >> 1) - 4;
        int n4 = this.e + 8;
        int n5 = this.a + 8;
        graphics.setClip(n2, n3, n4, n5);
        graphics.setColor(0x445566);
        graphics.fillRect(n2, n3, n4, n5);
        graphics.setColor(0xFFFFFF);
        graphics.drawRect(n2, n3, n4 - 1, n5 - 1);
        graphics.setColor(0xFFFFFF);
        this.a(graphics, n2 + 4, n3 + 4);
    }
}
