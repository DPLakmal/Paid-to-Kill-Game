/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Graphics
 */
import javax.microedition.lcdui.Graphics;

public class n {
    public static int b = 128;
    public static int c = 128;
    public String[] a = new String[2];
    public int d = 1;

    public final void a(String string, int n2) {
        if (h.a == null) {
            return;
        }
        this.a[n2] = string;
        if (this == h.a) {
            h.a.a(string, n2);
        }
    }

    public final void d(int n2) {
        if (h.a == null) {
            return;
        }
        this.d = n2;
        if (this == h.a) {
            h.a.a = n2;
        }
    }

    public void a(Graphics graphics) {
    }

    public void b(int n2) {
    }

    public void e(int n2) {
    }

    public void a(int n2, int n3, char c) {
    }

    public void a() {
    }

    public void c(int n2) {
    }
}
