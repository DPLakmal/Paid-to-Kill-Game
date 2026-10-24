/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Font
 *  javax.microedition.lcdui.Graphics
 */
import java.io.DataInputStream;
import java.io.IOException;
import java.util.Vector;
import javax.microedition.lcdui.Font;
import javax.microedition.lcdui.Graphics;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class e
extends n {
    public static int a = -1;
    public static int e = -1;
    private static k a = null;
    private static int[] a;
    private static int[] b;
    private int j = -1;
    private String a;
    private int k;
    private int l;
    private int m = 0;
    private int n = 0;
    private int o = 1;
    private Font a;
    private int[] c;
    private int[] d;
    private String[] b;
    private boolean[] a;
    private Vector a;
    public int f = -1;
    private int p = 0;
    private int q = -1;
    private int r;
    public int g;
    private boolean a = false;
    public int h;
    private boolean b = false;
    private int s;
    private int t;
    private int u;
    private int v;
    public int i;

    public static final void b() {
        a = new int[8];
        b = new int[8];
    }

    public e(String string, int n2) {
        this.c = new int[2];
        this.d = new int[2];
        this.b = new String[2];
        this.a = new boolean[2];
        this.a = new Vector();
        this.b(string, n2);
        this.d(2);
    }

    private final void c() {
        this.h = -1;
        if (this.h == -1) {
            Font font = Font.getFont((int)32, (int)0, (int)0);
            this.h = font.getHeight() + 4;
        }
        this.g = -1;
        if (this.g == -1) {
            this.g = this.a.getHeight() + 4;
            if (this.l != -1) {
                this.g = Math.max(this.g, b.a(this.l, 3));
            }
        }
        this.r = 0;
        this.s = 5;
        this.t = 11 + this.r + this.g;
        this.u = -5;
        if (this.u < 0) {
            this.u = n.b - this.s + this.u;
        }
        this.v = -11;
        if (this.v < 0) {
            this.v = n.c - this.h - this.t + this.v;
        }
        this.i = this.u - 4;
    }

    public final int a(c[] cArray, int n2, int n3, int n4) {
        f f2 = new f();
        new f().a = cArray;
        f2.a = (byte)n2;
        f2.a = (short)n3;
        f2.b = (short)n4;
        this.a.addElement(f2);
        int n5 = this.a.size() - 1;
        if (this.f == -1) {
            this.f(n5);
        }
        return n5;
    }

    public final int a(c c2, int n2) {
        return this.a(new c[]{c2}, 1, n2, -1);
    }

    public final void a(int n2) {
        if (this.f == n2) {
            this.f(this.d(this.f));
            if (this.f == -1) {
                this.f(this.e(this.f));
            }
        }
        if (this.f != -1 && this.f > n2) {
            this.f(this.f - 1);
        }
        this.a.removeElementAt(n2);
        this.g();
    }

    public final void f(int n2) {
        if (n2 != -1) {
            if (this.a(n2)) {
                this.f = n2;
                if (this.j != -1) {
                    e.a[this.j] = n2;
                }
                this.d();
                this.d(2);
                this.g();
                return;
            }
        } else {
            this.f = -1;
        }
    }

    public final void b(String string, int n2) {
        this.a.stringWidth("x");
        this.a = string;
        this.k = this.a.stringWidth(this.a);
        this.l = n2;
        this.c();
    }

    public final void a(int n2, String string, int n3, int n4) {
        this.c[n2] = n3;
        this.d[n2] = n4;
        this.b[n2] = string;
        this.a[n2] = true;
        this.d();
    }

    private void d() {
        if (this.f != -1) {
            this.a.elementAt(this.f);
        }
        Object var1_1 = null;
        for (int i = 0; i < 2; ++i) {
            int n2 = i == 0 ? 0 : 1;
            this.a(this.b[i], n2);
        }
    }

    public final void g(int n2) {
        int n3 = n2 == 0 ? 0 : 1;
        this.a((String)null, n3);
        this.b[n2] = null;
        this.a[n2] = false;
        this.d();
    }

    public final boolean a(int n2) {
        if (n2 < 0 || n2 >= this.a.size()) {
            return false;
        }
        return ((f)this.a.elementAt((int)n2)).a != 0;
    }

    public final int a(int n2) {
        return ((f)this.a.elementAt((int)n2)).a;
    }

    public final void a(int n2, int n3) {
        ((f)this.a.elementAt((int)n2)).a = n3;
    }

    public final void a(int n2, String string) {
        f f2 = (f)this.a.elementAt(n2);
        f2.a[0] = new c(string, f2.a[0].b, f2.a[0].a, f2.a[0].a);
    }

    private int b(int n2) {
        int n3 = 0;
        for (int i = 0; i < n2; ++i) {
            f f2 = (f)this.a.elementAt(i);
            n3 += this.a(f2) + 2;
        }
        return n3;
    }

    private int c(int n2) {
        f f2 = (f)this.a.elementAt(n2);
        return this.b(n2) + this.a(f2);
    }

    private int a(f f2) {
        return f2.a[f2.a].c + 4;
    }

    private int d(int n2) {
        for (int i = n2 - 1; i >= 0; --i) {
            if (!this.a(i)) continue;
            return i;
        }
        return -1;
    }

    private int e(int n2) {
        for (int i = n2 + 1; i < this.a.size(); ++i) {
            if (!this.a(i)) continue;
            return i;
        }
        return -1;
    }

    private void e() {
        if (this.a.size() == 0) {
            return;
        }
        int n2 = this.d(this.f);
        int n3 = this.p;
        if (n2 == -1) {
            n3 -= 20;
        } else {
            int n4 = this.b(n2);
            int n5 = this.c(n2);
            if (n3 <= n4) {
                this.f(n2);
            } else if (n5 > n3 - 20) {
                this.f(n2);
                n3 = this.p;
            } else {
                n3 -= 20;
            }
        }
        if (n3 < 0) {
            n3 = 0;
        }
        this.p = n3;
    }

    private void f() {
        int n2;
        if (this.a.size() == 0) {
            return;
        }
        int n3 = this.e(this.f);
        int n4 = this.p;
        if (n3 == -1) {
            n4 += 20;
        } else {
            n2 = this.b(n3);
            int n5 = this.c(n3);
            if (n4 + this.v > n5) {
                this.f(n3);
            } else if (n2 < n4 + this.v + 20) {
                this.f(n3);
                n4 = this.p;
            } else {
                n4 += 20;
            }
        }
        n2 = this.c(this.a.size() - 1);
        if (n2 <= this.v) {
            n4 = 0;
        } else if (n4 > n2 - this.v) {
            n4 = n2 - this.v;
        }
        this.p = n4;
    }

    private void g() {
        if (this.f == -1) {
            return;
        }
        int n2 = this.b(this.f);
        int n3 = this.c(this.f);
        if (n2 < this.p) {
            this.p = n2;
        } else if (n3 > this.p + this.v) {
            this.p = n3 - this.v;
        }
        if (this.j != -1) {
            e.b[this.j] = this.p;
        }
    }

    public final void b(int n2) {
        if (!h.a(this.q)) {
            return;
        }
        f f2 = this.f != -1 ? (f)this.a.elementAt(this.f) : null;
        if (f2 != null && !f2.a) {
            f2 = null;
        }
        int n3 = f2 != null ? (int)f2.a : -1;
        int n4 = -1;
        int n5 = -1;
        switch (n2) {
            case 5: 
            case 6: 
            case 7: {
                int n6;
                boolean bl = false;
                if (n2 == 6) {
                    n6 = 1;
                } else {
                    n6 = 0;
                    if (n3 == 2) {
                        ++f2.a;
                        if (f2.a >= f2.a.length) {
                            f2.a = 0;
                        }
                    }
                }
                if (!this.a[n6]) break;
                if (this.c[n6] != 0) {
                    n4 = this.c[n6];
                    n5 = this.d[n6];
                    break;
                }
                if (f2 == null) break;
                n4 = f2.a;
                n5 = f2.b;
                break;
            }
            case 3: {
                if (n3 != 2) break;
                --f2.a;
                if (f2.a < 0) {
                    f2.a = f2.a.length - 1;
                }
                n4 = f2.a;
                n5 = f2.b;
                break;
            }
            case 4: {
                if (n3 != 2) break;
                ++f2.a;
                if (f2.a >= f2.a.length) {
                    f2.a = 0;
                }
                n4 = f2.a;
                n5 = f2.b;
                break;
            }
            case 30: {
                break;
            }
            case 1: {
                this.e();
                break;
            }
            case 2: {
                this.f();
            }
        }
        if (n4 != -1) {
            if (n4 == 1) {
                h.a(e.a(n5));
                return;
            }
            this.q = h.a(n4, this);
        }
    }

    public final void a(int n2, int n3, char c2) {
        throw new RuntimeException("Unsupported operation");
    }

    public final void c(int n2) {
        int n3;
        int n4;
        int n5;
        if (this.f != -1) {
            this.a.elementAt(this.f);
            Object var2_2 = null;
        }
        if ((n5 = (n4 = n.b - 4) - (n3 = this.l != -1 ? b.a(this.l, 2) + 2 : 0)) < this.k) {
            if (this.m >= 3000) {
                if (this.o > 0) {
                    this.n = (this.m - 3000) * 20 / 1000;
                    if (this.n > this.k - n5) {
                        this.n = this.k - n5;
                        this.m = 0;
                        this.o = -1;
                    }
                } else {
                    this.n = this.k - n5 - (this.m - 3000) * 20 / 1000;
                    if (this.n <= 0) {
                        this.n = 0;
                        this.m = 0;
                        this.o = 1;
                    }
                }
            }
            this.m += n2;
        }
    }

    public final void a(Graphics graphics) {
        int n2;
        int n3;
        graphics.setColor(3158580);
        graphics.fillRect(0, 0, n.b, n.c);
        if (this.a) {
            graphics.setColor(3158580);
            graphics.fillRect(0, 0, n.b, this.g);
        }
        int n4 = 0;
        if (this.l != -1) {
            n4 = b.a(this.l, 2) + 2;
            b.a(2 + b.a(this.l, 4), this.r + 2 + b.a(this.l, 5), this.l, graphics);
        }
        int n5 = 2 + n4;
        int n6 = n.b - 4;
        graphics.setFont(this.a);
        graphics.setClip(n5, this.r, n6 - n4, this.g);
        if (this.k > n6 || this.l != -1) {
            graphics.setColor(0);
            graphics.drawString(this.a, n5 - this.n + 1, this.r + 2 + 1, 20);
            graphics.setColor(0xFFFFFF);
            graphics.drawString(this.a, n5 - this.n, this.r + 2, 20);
        } else {
            graphics.setColor(0);
            graphics.drawString(this.a, (n.b >> 1) + 1, this.r + 2 + 1, 17);
            graphics.setColor(0xFFFFFF);
            graphics.drawString(this.a, n.b >> 1, this.r + 2, 17);
        }
        graphics.setClip(0, 0, n.b, n.c);
        if (this.b) {
            graphics.setColor(3158580);
            graphics.fillRect(0, n.c - this.h, n.b, this.h);
        }
        if (a != -1 && this.p > 0) {
            n3 = b.a(a, 4) - (b.a(a, 2) >> 1);
            n2 = b.a(a, 5) - b.a(a, 3);
            b.a(n3 += this.s + (this.u >> 1), n2 += this.t - 2, a, graphics);
        }
        if (e != -1 && !this.a.isEmpty() && this.p < this.c(this.a.size() - 1) - this.v) {
            n3 = b.a(e, 4) - (b.a(e, 2) >> 1);
            n2 = b.a(e, 5);
            b.a(n3 += this.s + (this.u >> 1), n2 += this.t + this.v + 2, e, graphics);
        }
        graphics.setClip(this.s, this.t, this.u, this.v);
        for (n3 = 0; n3 < this.a.size(); ++n3) {
            f f2 = (f)this.a.elementAt(n3);
            int n7 = this.b(n3);
            if (n7 > this.p + this.v) {
                return;
            }
            int n8 = this.a(f2);
            int n9 = n7 + n8;
            if (n9 < this.p) continue;
            int n10 = this.s;
            int n11 = this.t + n7 - this.p;
            if (n3 == this.f) {
                graphics.setColor(16745728);
                graphics.fillRect(n10, n11, this.u, n8);
                graphics.setColor(16745728);
                graphics.drawRect(n10, n11, this.u - 1, n8 - 1);
            }
            int n12 = f2.a ? (n3 == this.f ? 0xFFFFFF : 0xFFFFFF) : (n3 == this.f ? 0x888888 : 0x888888);
            graphics.setColor(0);
            f2.a[f2.a].a(graphics, n10 + 2 + 1, n11 + 2 + 1);
            graphics.setColor(n12);
            f2.a[f2.a].a(graphics, n10 + 2, n11 + 2);
        }
    }

    public static final void a(k k2) {
        a = k2;
    }

    public static final e a(int n2) {
        int n3 = a[n2];
        try {
            DataInputStream dataInputStream = new DataInputStream(h.a.getClass().getResourceAsStream("/m"));
            e e2 = null;
            dataInputStream.readInt();
            for (int i = 0; i <= n2; ++i) {
                int n4;
                short s;
                int n5;
                int n6;
                boolean bl = i == n2;
                short s2 = dataInputStream.readShort();
                short s3 = dataInputStream.readShort();
                dataInputStream.readInt();
                if (bl) {
                    e2 = new e((String)b.a(s2), s3);
                    new e((String)b.a(s2), s3).j = n2;
                }
                int n7 = dataInputStream.readInt();
                for (n6 = 0; n6 < n7; ++n6) {
                    n5 = dataInputStream.readByte();
                    s2 = dataInputStream.readShort();
                    s = dataInputStream.readShort();
                    n4 = dataInputStream.readShort();
                    --n5;
                    if (!bl) continue;
                    e2.a(n5, (String)b.a(s2), (int)s, n4);
                }
                n6 = dataInputStream.readShort();
                for (n5 = 0; n5 < n6; ++n5) {
                    int n8;
                    int n9;
                    byte by = dataInputStream.readByte();
                    s = by;
                    n4 = by != 2 ? 1 : dataInputStream.readShort();
                    c[] cArray = new c[n4];
                    for (n9 = 0; n9 < n4; ++n9) {
                        int[] nArray;
                        s2 = dataInputStream.readShort();
                        s3 = dataInputStream.readShort();
                        int n10 = dataInputStream.readInt();
                        if (!bl) continue;
                        if (s3 != -1) {
                            int[] nArray2 = new int[1];
                            nArray = nArray2;
                            nArray2[0] = s3;
                        } else {
                            nArray = null;
                        }
                        int[] nArray3 = nArray;
                        cArray[n9] = new c((String)b.a(s2), e2.i, n10, nArray3);
                    }
                    n9 = dataInputStream.readShort();
                    int n11 = n8 = s != 2 ? (int)dataInputStream.readShort() : -1;
                    if (!bl) continue;
                    e2.a(cArray, s, n9, n8);
                }
            }
            dataInputStream.close();
            e2.f(n3);
            if (a != null) {
                a.a(e2, n2);
            }
            return e2;
        }
        catch (IOException iOException) {
            return null;
        }
    }
}
