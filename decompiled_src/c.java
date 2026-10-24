/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Font
 *  javax.microedition.lcdui.Graphics
 */
import java.util.Vector;
import javax.microedition.lcdui.Font;
import javax.microedition.lcdui.Graphics;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class c {
    private static final char[] a = new char[]{'\n', ' ', '-'};
    public int[] a;
    public final int a;
    private Font a;
    private int d;
    private int e;
    private final int f;
    private final int g;
    private int h = 0;
    public final int b;
    public final int c;
    public final String[] a;

    public c(String string, int n, int n2) {
        this(string, n, n2, null);
    }

    public c(String string, int n, int n2, int[] nArray) {
        int n3;
        int n4;
        int n5;
        int n6;
        int n7 = 0;
        int n8 = 0;
        int n9 = 0;
        int n10 = 0;
        int n11 = 0;
        int n12 = 0;
        Vector<String> vector = new Vector<String>(2);
        this.a = nArray;
        this.a = n2;
        this.a = (this.a & 1) == 1 ? Font.getFont((int)64, (int)1, (int)0) : Font.getFont((int)64, (int)0, (int)8);
        if (nArray != null) {
            this.g = b.a(nArray[0], 3);
            n6 = b.a(nArray[0], 2);
        } else {
            this.g = 0;
            n6 = 0;
        }
        if (n <= n6) {
            this.h = this.g;
        }
        int n13 = 0;
        while (n13 < string.length()) {
            n7 = this.h + n8 * this.a.getHeight() < this.g ? n - n6 - 5 : n;
            n10 = n13;
            n12 = 0;
            while (n12 < n7) {
                for (n11 = 0; n11 < a.length; ++n11) {
                    n9 = string.indexOf(a[n11], n10);
                    if (n11 == 0 && n10 == n9) {
                        n12 = 1;
                        if (n11 != 0) break;
                        n11 = a.length;
                        break;
                    }
                    if (n11 != 0 && n9 <= n10 + 1) {
                        n9 = string.indexOf(a[n11], n10 + 1);
                    }
                    if (n9 == -1) {
                        n9 = string.length();
                    } else if (n11 != 1 && n11 != 0) {
                        ++n9;
                    }
                    if (n10 == n9 || n12 + this.a.stringWidth(string.substring(n10, n9)) > n7) continue;
                    n12 += this.a.stringWidth(string.substring(n10, n9));
                    n10 = n9;
                    if (n11 != 0) break;
                    n11 = a.length;
                    break;
                }
                if (n11 != a.length) continue;
            }
            if (n12 == 0) {
                StringBuffer stringBuffer = new StringBuffer();
                n5 = 0;
                n4 = n13;
                while (n4 < string.length()) {
                    if (this.a.stringWidth(stringBuffer.toString()) >= n7) {
                        if (n5 <= 0) break;
                        stringBuffer.deleteCharAt(--n5);
                        break;
                    }
                    stringBuffer.append(string.charAt(n4));
                    ++n4;
                    ++n5;
                }
                n13 += n5;
                vector.addElement(stringBuffer.toString());
            } else {
                vector.addElement(string.substring(n13, n10));
                n13 = n10;
            }
            if (n13 >= 0 && n13 < string.length()) {
                if (string.charAt(n13) == '\n') {
                    ++n13;
                }
                if (string.charAt(n13) == ' ') {
                    ++n13;
                }
            }
            ++n8;
        }
        if (string.length() == 0) {
            vector.addElement("");
        }
        n13 = vector.size();
        this.a = new String[n13];
        for (n3 = 0; n3 < n13; ++n3) {
            this.a[n3] = vector.elementAt(n3).toString();
        }
        if (this.a != null) {
            if ((this.a & 2) != 0) {
                n3 = 0;
                n5 = this.h;
                for (n4 = 0; n4 < n13 && n5 < this.g; n5 += this.a.getHeight(), ++n4) {
                    int n14 = this.a.stringWidth(this.a[n4]);
                    if (n14 <= n3) continue;
                    n3 = n14;
                }
                this.e = n3 == 0 ? n - n6 >> 1 : n - (n3 + n6 + 5) >> 1;
            } else {
                this.e = 0;
            }
            this.f = this.e + n6 + 5;
            this.e += b.a(this.a[0], 4);
            this.d = b.a(this.a[0], 5);
        } else {
            this.e = 0;
            this.d = 0;
            this.f = 0;
        }
        this.b = n;
        this.c = Math.max(n13 * this.a.getHeight() + this.h, this.g);
    }

    public final void a(Graphics graphics, int n, int n2) {
        graphics.setFont(this.a);
        int n3 = this.a.length;
        int n4 = this.h;
        for (int i = 0; i < n3; ++i) {
            boolean bl;
            boolean bl2 = bl = n4 < this.g;
            if ((this.a & 2) == 2 && !bl) {
                graphics.drawString(this.a[i], n + (this.b >> 1), n2 + n4, 17);
            } else {
                graphics.drawString(this.a[i], n + (bl ? this.f : 0), n2 + n4, 20);
            }
            n4 += this.a.getHeight();
        }
        if (this.a != null) {
            b.a(n + this.e, n2 + this.d, this.a[0], graphics);
        }
    }
}
