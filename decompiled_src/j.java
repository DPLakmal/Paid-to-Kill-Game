/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  com.nokia.mid.ui.FullCanvas
 *  javax.microedition.lcdui.Font
 *  javax.microedition.lcdui.Graphics
 */
import com.nokia.mid.ui.FullCanvas;
import javax.microedition.lcdui.Font;
import javax.microedition.lcdui.Graphics;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class j
extends FullCanvas {
    private String[] a;
    private Font a;
    public static final char[][] a = new char[][]{{' ', '0'}, {'.', ',', '?', '!', '\'', '-', '(', ')', '@', '/', ':', '_', '1'}, {'a', 'b', 'c', '\u00e4', '\u00e5', '2'}, {'d', 'e', 'f', '3'}, {'g', 'h', 'i', '4'}, {'j', 'k', 'l', '5'}, {'m', 'n', 'o', '\u00f6', '6'}, {'p', 'q', 'r', 's', '7'}, {'t', 'u', 'v', '8'}, {'w', 'x', 'y', 'z', '9'}};
    public int a;
    private long a = 0L;
    private int b = 0;
    private int c = 0;

    public final void a(String string, int n) {
        this.a[n] = string;
    }

    public final void paint(Graphics graphics) {
        boolean bl = false;
        n n2 = h.a;
        try {
            Graphics graphics2 = graphics;
            if (n2 != null) {
                graphics2.setClip(0, 0, n.b, n.c);
                n2.a(graphics2);
                graphics2.setFont(this.a);
                graphics2.setClip(0, 0, n.b, n.c);
                int n3 = n.c - 2;
                String string = this.a[0];
                String string2 = this.a[1];
                int n4 = 2;
                int n5 = 36;
                for (int i = 0; i < 2; ++i) {
                    if (string != null && string.length() > 0) {
                        graphics2.setColor(0);
                        graphics2.drawString(string, n4, n3 - 1, n5);
                        graphics2.drawString(string, n4 + 1, n3, n5);
                        graphics2.drawString(string, n4 - 1, n3, n5);
                        graphics2.drawString(string, n4, n3 + 1, n5);
                        graphics2.setColor(0xFFFFFF);
                        graphics2.drawString(string, n4, n3, n5);
                    }
                    n4 = n.b - 2;
                    string = string2;
                    n5 = 40;
                }
            }
            return;
        }
        catch (Throwable throwable) {
            return;
        }
    }

    private int a(int n2) {
        switch (n2) {
            case 48: {
                return 10;
            }
            case 49: {
                return 11;
            }
            case 50: {
                return 12;
            }
            case 51: {
                return 13;
            }
            case 52: {
                return 14;
            }
            case 53: {
                return 15;
            }
            case 54: {
                return 16;
            }
            case 55: {
                return 17;
            }
            case 56: {
                return 18;
            }
            case 57: {
                return 19;
            }
            case 42: {
                return 20;
            }
            case 35: {
                return 21;
            }
            case -6: {
                return 5;
            }
            case -7: {
                return 6;
            }
            case -5: {
                return 7;
            }
        }
        try {
            n2 = this.getGameAction(n2);
        }
        catch (IllegalArgumentException illegalArgumentException) {
            return -1;
        }
        switch (n2) {
            case 6: {
                return 2;
            }
            case 1: {
                return 1;
            }
            case 2: {
                return 3;
            }
            case 5: {
                return 4;
            }
        }
        return -1;
    }

    public final void keyPressed(int n2) {
        boolean bl = false;
        n n3 = h.a;
        try {
            if (n3 != null) {
                int n4 = this.a(n2);
                if (this.a == 3 && (n4 >= 10 && n4 <= 21 || n4 == 21)) {
                    this.a(n4);
                } else {
                    n3.b(n4);
                }
            }
            return;
        }
        catch (Throwable throwable) {
            return;
        }
    }

    public final void keyReleased(int n2) {
        boolean bl = false;
        n n3 = h.a;
        try {
            if (n3 != null) {
                int n4 = this.a(n2);
                if (this.a == 3) {
                    long l;
                    if (n4 >= 10 && n4 <= 19 && (l = System.currentTimeMillis()) - this.a > 1200L) {
                        char c = a[n4 - 10][a[n4 - 10].length - 1];
                        n3.a(102, n2, c);
                        this.c = 0;
                        this.a = 0L;
                    }
                } else {
                    n3.e(this.a(n2));
                }
            }
            return;
        }
        catch (Throwable throwable) {
            return;
        }
    }

    public final void showNotify() {
        h.a(11);
    }

    public final void hideNotify() {
        h.a(12);
    }

    private final void a(int n2) {
        long l = System.currentTimeMillis();
        this.c = l - this.a < 700L && n2 == this.b ? ++this.c : 0;
        if (n2 == 21) {
            h.a.a(103, n2, '\u0000');
            return;
        }
        int n3 = n2 - 10;
        this.a = l;
        this.b = n2;
        if (n3 < a.length && a[n3].length > 0) {
            h.a.a(this.c > 0 ? 101 : 100, n2, a[n3][this.c % a[n3].length]);
        }
    }
}
