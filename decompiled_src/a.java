/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Graphics
 */
import javax.microedition.lcdui.Graphics;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class a
extends n {
    private int e = 0;
    private boolean b = true;
    private boolean c = false;
    private int f = 100;
    private int g = 0;
    private int h = 1;
    private int i;
    public int a;
    public boolean a;
    private int j = -1;
    private int k = -1;
    private c a = null;
    private int l = 3158580;

    private a() {
    }

    public static final a a(int n2, int n3) {
        a a2 = new a();
        new a().k = n2;
        a2.l = n3;
        return a2;
    }

    public static final a a(int n2) {
        a a2 = new a();
        new a().k = n2;
        a2.c = true;
        return a2;
    }

    public static final a b(int n2, int n3) {
        a a2 = new a();
        new a().k = n2;
        a2.c = true;
        a2.l = n3;
        return a2;
    }

    public final void a(int n2) {
        this.i = this.e = 0;
        this.j = n2;
    }

    public final void a() {
        this.i = this.e = 0;
        this.b = true;
    }

    public final void b(int n2) {
        if (this.a != -1 && this.a) {
            h.a(this.a, this);
        }
    }

    public final void c(int n2) {
        this.e += n2;
        if (this.a != -1 && this.j != -1 && this.e > this.j) {
            h.a(this.a, this);
        }
        if (this.c && this.h != 0) {
            if (this.e - this.i >= 4000) {
                this.i = this.e;
                this.h = -this.h;
            }
            this.g = this.f * (this.e - this.i) / 4000;
            if (this.h < 0) {
                this.g = this.f - this.g;
            }
        }
        try {
            Thread.sleep(100L);
            return;
        }
        catch (InterruptedException interruptedException) {
            return;
        }
    }

    public final void a(Graphics graphics) {
        int n2 = -4;
        if (this.k != -1) {
            n2 = -4 + (b.a(this.k, 3) + 4);
        }
        if (this.a != null) {
            n2 += this.a.c + 4;
        }
        if (this.c) {
            n2 += 12;
        }
        int n3 = 0;
        n3 = n.c - n2 >> 1;
        if (this.b) {
            graphics.setColor(this.l);
            graphics.setClip(0, 0, n.b << 1, n.c << 1);
            graphics.fillRect(0, 0, n.b << 1, n.c << 1);
        }
        if (this.k != -1) {
            if (this.b) {
                b.a((n.b - b.a(this.k, 2) >> 1) + b.a(this.k, 4), n3 + b.a(this.k, 5), this.k, graphics);
            }
            n3 += b.a(this.k, 3) + 4;
        }
        if (this.a != null) {
            if (this.b) {
                graphics.setColor(0);
                this.a.a(graphics, 0, n3);
            }
            n3 += this.a.c + 4;
        }
        if (this.c) {
            int n4 = (n.b >> 1) - 50;
            int n5 = ((this.g << 8) / this.f * 100 >> 8) - 4;
            graphics.setClip(n4, n3, 100, 8);
            graphics.setColor(0xFFFFFF);
            graphics.drawRect(n4, n3, 99, 7);
            graphics.setColor(0);
            graphics.fillRect(n4 + 1, n3 + 1, 98, 6);
            graphics.setClip(n4 + 2, n3, 96, 8);
            graphics.setColor(16745728);
            if (this.h != 0) {
                graphics.fillRect(n4 - 4 + n5, n3 + 2, 8, 4);
            } else {
                graphics.fillRect(n4 + 2, n3 + 2, n5, 4);
            }
        }
        this.b = false;
    }
}
