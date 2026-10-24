/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Graphics
 *  javax.microedition.lcdui.Image
 */
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class m {
    private int a;
    private int b;
    private int c;
    private int d;
    private int e;
    private int f;
    private int g;
    private int h;
    private Image a;
    private Graphics a;

    public m(int n, int n2, int n3, int n4, int n5, int n6) {
        this.a = n;
        this.b = n2;
        this.c = n >> 1;
        this.d = n2 >> 1;
        this.e = n3;
        this.f = n4;
        this.g = n5;
        this.h = n6;
        this.a = Image.createImage((int)n, (int)n2);
        this.a = this.a.getGraphics();
    }

    public final void a(Graphics graphics, int n, int n2, int n3, int n4) {
        if (this.a == null) {
            return;
        }
        int n5 = graphics.getClipX();
        int n6 = graphics.getClipY();
        int n7 = graphics.getClipWidth();
        int n8 = graphics.getClipHeight();
        int n9 = n % this.a;
        int n10 = n2 % this.b;
        int n11 = n9 - this.c;
        int n12 = n10 - this.d;
        n9 += this.c;
        n10 += this.d;
        if (n11 <= 0 && n12 <= 0) {
            graphics.setClip(-n11 + n3, -n12 + n4, this.a + n11, this.b + n12);
            graphics.drawImage(this.a, -n11 + n3, -n12 + n4, 0);
            graphics.setClip(n3, -n12 + n4, -n11, this.b + n12);
            graphics.drawImage(this.a, -this.a - n11 + n3, -n12 + n4, 0);
            graphics.setClip(n3, n4, -n11, -n12);
            graphics.drawImage(this.a, -this.a - n11 + n3, -this.b - n12 + n4, 0);
            graphics.setClip(-n11 + n3, n4, this.a + n11, -n12);
            graphics.drawImage(this.a, -n11 + n3, -this.b - n12 + n4, 0);
        } else if (n11 <= 0 && n10 >= this.b) {
            int n13 = n10 - this.b;
            graphics.setClip(-n11 + n3, n4, this.a + n11, this.b - n13);
            graphics.drawImage(this.a, -n11 + n3, -n13 + n4, 0);
            graphics.setClip(n3, n4, -n11, this.b - n13);
            graphics.drawImage(this.a, -this.a - n11 + n3, -n13 + n4, 0);
            graphics.setClip(n3, this.b - n13 + n4, -n11, n13);
            graphics.drawImage(this.a, -this.a - n11 + n3, this.b - n13 + n4, 0);
            graphics.setClip(-n11 + n3, this.b - n13 + n4, this.a + n11, n13);
            graphics.drawImage(this.a, -n11 + n3, this.b - n13 + n4, 0);
        } else if (n9 >= this.a && n12 <= 0) {
            int n14 = n9 - this.a;
            graphics.setClip(n3, -n12 + n4, this.a - n14, this.b + n12);
            graphics.drawImage(this.a, -n14 + n3, -n12 + n4, 0);
            graphics.setClip(this.a - n14 + n3, -n12 + n4, n14, this.b + n12);
            graphics.drawImage(this.a, this.a - n14 + n3, -n12 + n4, 0);
            graphics.setClip(this.a - n14 + n3, n4, n14, -n12);
            graphics.drawImage(this.a, this.a - n14 + n3, -this.b - n12 + n4, 0);
            graphics.setClip(n3, n4, this.a - n14, -n12);
            graphics.drawImage(this.a, -n14 + n3, -this.b - n12 + n4, 0);
        } else {
            int n15 = n9 - this.a;
            int n16 = n10 - this.b;
            graphics.setClip(n3, n4, this.a - n15, this.b - n16);
            graphics.drawImage(this.a, -n15 + n3, -n16 + n4, 0);
            graphics.setClip(this.a - n15 + n3, n4, n15, this.b - n16);
            graphics.drawImage(this.a, this.a - n15 + n3, -n16 + n4, 0);
            graphics.setClip(this.a - n15 + n3, this.b - n16 + n4, n15, n16);
            graphics.drawImage(this.a, this.a - n15 + n3, this.b - n16 + n4, 0);
            graphics.setClip(n3, this.b - n16 + n4, this.a - n15, n16);
            graphics.drawImage(this.a, -n15 + n3, this.b - n16 + n4, 0);
        }
        graphics.setClip(n5, n6, n7, n8);
    }

    public final void a(int n, int n2, int n3, int n4, int n5, int n6) {
        int n7 = n5 - this.c;
        int n8 = n5 + this.c - 1;
        int n9 = n6 - this.d;
        int n10 = n6 + this.d - 1;
        if (n >= n8 || n2 >= n10 || n3 <= n7 || n4 <= n9) {
            return;
        }
        if (n < n7) {
            n = n7;
        }
        if (n2 < n9) {
            n2 = n9;
        }
        if (n3 > n8) {
            n3 = n8;
        }
        if (n4 > n10) {
            n4 = n10;
        }
        this.a(n, n2, n3, n4);
    }

    public final void a(int n2, int n3, int n4, int n5) {
        Graphics graphics = this.a;
        int n6 = n2 / this.e;
        int n7 = n3 / this.f;
        int n8 = n4 / this.e;
        int n9 = n5 / this.f;
        if (n6 < 0) {
            n6 = 0;
        }
        if (n8 >= this.g) {
            n8 = this.g - 1;
        }
        if (n7 < 0) {
            n7 = 0;
        }
        if (n9 >= this.h) {
            n9 = this.h - 1;
        }
        boolean bl = false;
        boolean bl2 = false;
        for (int i = n7; i <= n9; ++i) {
            int n10;
            int n11 = n3 - i * this.f;
            if (n11 < 0) {
                n11 = 0;
            }
            if ((n10 = n5 - i * this.f + 1) > this.f) {
                n10 = this.f;
            }
            n10 -= n11;
            int n12 = (i * this.f + this.b) % this.b;
            n11 += n12;
            for (int j = n6; j <= n8; ++j) {
                int n13;
                int n14;
                int n15;
                int n16;
                int n17;
                int n18 = i * this.g + j;
                int n19 = this.a(d.k[n18]);
                int n20 = n2 - j * this.e;
                if (n20 < 0) {
                    n20 = 0;
                }
                if ((n17 = n4 - j * this.e + 1) > this.e) {
                    n17 = this.e;
                }
                n17 -= n20;
                int n21 = (j * this.e + this.a) % this.a;
                graphics.setClip(n20 += n21, n11, n17, n10);
                this.a(n21, n12, n19, graphics, n18);
                int n22 = 0;
                if (n20 + n17 >= this.a) {
                    if (n20 < this.a) {
                        graphics.setClip(0, n11, n20 + n17 - this.a, n10);
                    } else {
                        graphics.setClip(n20 - this.a, n11, n17, n10);
                    }
                    this.a(n21 - this.a, n12, n19, graphics, n18);
                    ++n22;
                }
                if (n11 + n10 >= this.b) {
                    if (n11 < this.b) {
                        graphics.setClip(n20, 0, n17, n11 + n10 - this.b);
                    } else {
                        graphics.setClip(n20, n11 - this.b, n17, n10);
                    }
                    this.a(n21, n12 - this.b, n19, graphics, n18);
                    ++n22;
                }
                if (n22 != 2) continue;
                if (n20 < this.a) {
                    n16 = 0;
                    n15 = n20 + n17 - this.a;
                } else {
                    n16 = n20 - this.a;
                    n15 = n17;
                }
                if (n11 < this.b) {
                    n14 = 0;
                    n13 = n11 + n10 - this.b;
                } else {
                    n14 = n11 - this.b;
                    n13 = n10;
                }
                graphics.setClip(n16, n14, n15, n13);
                this.a(n21 - this.a, n12 - this.b, n19, graphics, n18);
            }
        }
    }

    public final void a(int n2, int n3) {
        int n4 = n2 - (this.a >> 1);
        int n5 = n2 + (this.a >> 1) - 1;
        int n6 = n3 - (this.b >> 1);
        int n7 = n3 + (this.b >> 1) - 1;
        this.a(n4, n6, n5, n7);
    }

    public final void b(int n2, int n3, int n4, int n5) {
        int n6;
        int n7;
        int n8 = n5 - this.d;
        int n9 = n5 + this.d - 1;
        if (n4 < n2) {
            n7 = n4 - this.c;
            n6 = n2 - this.c - 1;
            this.a(n7, n8, n6, n9);
        } else if (n4 > n2) {
            n7 = n2 + this.c;
            n6 = n4 + this.c - 1;
            this.a(n7, n8, n6, n9);
        }
        n7 = n4 - this.c;
        n6 = n4 + this.c - 1;
        if (n5 < n3) {
            n8 = n5 - this.d;
            n9 = n3 - this.d - 1;
            this.a(n7, n8, n6, n9);
            return;
        }
        if (n5 > n3) {
            n8 = n3 + this.d;
            n9 = n5 + this.d - 1;
            this.a(n7, n8, n6, n9);
        }
    }

    public final int a(byte by) {
        return by & 0xFF;
    }

    private void a(int n2, int n3, int n4, Graphics graphics, int n5) {
        if (!d.b && ((d.i[n4] & 2) != 0 || n4 >= d.B && (d.i[d.c(n4)] & 2) != 0)) {
            m.a(n2, n3, n4, graphics);
            return;
        }
        if (!d.a[n5] && ((d.i[n4] & 2) != 0 || n4 >= d.B && (d.i[d.c(n4)] & 2) != 0)) {
            if (d.a) {
                m.a(n2, n3, n4, graphics);
                return;
            }
            m.b(n2, n3, n4, graphics);
            return;
        }
        if (d.a || !d.b || d.b && d.a[n5]) {
            boolean bl = false;
            if (n4 >= d.B) {
                b.a(n2, n3, d.b(n4), graphics);
                b.a(n2, n3, d.c(n4), graphics);
            } else {
                b.a(n2, n3, n4, graphics);
            }
            return;
        }
        if (n5 - d.b > 0 && d.a[n5 - d.b] && (d.i[d.a(n5 - d.b)] & 0x10) == 0) {
            if (n4 >= d.B) {
                b.a(n2, n3, d.b(n4), graphics);
                return;
            }
            b.a(n2, n3, n4, graphics);
            return;
        }
        m.b(n2, n3, n4, graphics);
    }

    private static void b(int n2, int n3, int n4, Graphics graphics) {
        b.a(n2, n3, 82, graphics);
    }

    public static final void a(int n2, int n3, int n4, Graphics graphics) {
        int n5;
        boolean bl = false;
        if (n4 >= d.B) {
            switch (n4 - d.B) {
                case 6: {
                    n5 = 65;
                    break;
                }
                case 7: {
                    n5 = 65;
                    break;
                }
                case 8: {
                    n5 = 66;
                    break;
                }
                case 9: {
                    n5 = 75;
                    break;
                }
                case 10: {
                    n5 = 75;
                    break;
                }
                case 11: {
                    n5 = 76;
                    break;
                }
                case 12: {
                    n5 = 3;
                    break;
                }
                case 13: {
                    n5 = 3;
                    break;
                }
                default: {
                    n5 = 4;
                    break;
                }
            }
        } else {
            switch (n4) {
                case 61: {
                    n5 = 61;
                    break;
                }
                case 63: {
                    n5 = 63;
                    break;
                }
                case 62: {
                    n5 = 62;
                    break;
                }
                default: {
                    n5 = 4;
                }
            }
        }
        m.c(n2, n3, n5, graphics);
    }

    private static void c(int n2, int n3, int n4, Graphics graphics) {
        if (n4 >= d.B) {
            b.a(n2, n3, d.b(n4), graphics);
            b.a(n2, n3, d.c(n4), graphics);
            return;
        }
        b.a(n2, n3, n4, graphics);
    }
}
