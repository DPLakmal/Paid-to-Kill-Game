/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Alert
 *  javax.microedition.lcdui.AlertType
 *  javax.microedition.lcdui.Canvas
 *  javax.microedition.lcdui.Display
 *  javax.microedition.lcdui.Displayable
 *  javax.microedition.midlet.MIDlet
 */
package a;

import a.c;
import a.e;
import a.g;
import a.h;
import a.i;
import a.j;
import java.io.ByteArrayInputStream;
import java.io.DataInput;
import java.io.DataInputStream;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Stack;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.midlet.MIDlet;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public class f
implements Runnable {
    public static MIDlet a;
    public static int a;
    public static h a;
    private static Hashtable a;
    private static Stack a;
    public static f a;
    public static boolean a;
    private static Displayable a;
    private static int b;
    private static boolean b;
    private static byte[] b;
    public static final char[] a;
    public static final byte[] a;

    public static void a() {
        c.a();
        g.a(10);
        e.a(8);
    }

    public static void b() {
        c.b();
        f.a(3);
    }

    public static void a(int n, i i2) {
        a.put(new Integer(n), i2);
    }

    public static i a(int n) {
        return (i)a.get(new Integer(n));
    }

    public static void a(Display display, Displayable displayable) {
        b = true;
        if (!b) {
            a = displayable;
            Display.getDisplay((MIDlet)a).setCurrent(displayable);
        } else {
            a.push(displayable);
        }
    }

    public static void a(Displayable displayable) {
        Displayable displayable2;
        Display display = Display.getDisplay((MIDlet)a);
        while ((displayable2 = display.getCurrent()) instanceof Alert) {
            try {
                Thread.sleep(500L);
            }
            catch (InterruptedException interruptedException) {}
        }
        if (displayable2 != null) {
            a.push(displayable2);
        }
        a = displayable;
        display.setCurrent(displayable);
        ++b;
    }

    public static void c() {
        Display display = Display.getDisplay((MIDlet)a);
        a = null;
        if (!a.empty()) {
            if ((a = (Displayable)a.pop()) instanceof Alert) {
                Alert alert = (Alert)a;
                a = (Displayable)a.pop();
                display.setCurrent(alert, a);
            } else {
                display.setCurrent(a);
            }
        }
        --b;
    }

    public static boolean a(Canvas canvas) {
        String string = System.getProperty("microedition.platform");
        if (string == null || string.indexOf("Nokia6600") == -1) {
            try {
                canvas.setFullScreenMode(true);
                return true;
            }
            catch (Throwable throwable) {
                // empty catch block
            }
        }
        return false;
    }

    public static boolean a(String string) {
        try {
            boolean bl = a.platformRequest(string);
            if (bl) {
                a.notifyDestroyed();
            }
            return true;
        }
        catch (Exception exception) {
            return false;
        }
    }

    public static void a(String string, Throwable throwable) {
        Alert alert = new Alert("error", string, null, AlertType.ERROR);
        alert.setTimeout(-2);
        Display.getDisplay((MIDlet)a).setCurrent((Displayable)alert);
    }

    public static DataInputStream a(byte[] byArray, int n, int n2) {
        return new DataInputStream(new ByteArrayInputStream(byArray, n, n2));
    }

    public void d() {
        if (a) {
            this.run();
        } else {
            new Thread(this).start();
        }
    }

    public void run() {
        if (!a) {
            a = true;
            f.a();
            f.b();
        }
        try {
            ((RMIDlet)a).a();
        }
        catch (Throwable throwable) {
            f.a(throwable.getMessage(), throwable);
        }
    }

    public static final void a(DataInput dataInput, int n) throws IOException {
        while (n > 0) {
            int n2 = Math.min(n, b.length);
            dataInput.readFully(b, 0, n2);
            n -= n2;
        }
    }

    static {
        int n;
        a = 6760;
        a = new Hashtable();
        a = new Stack();
        a = new f();
        a = false;
        b = new byte[32];
        a = new char[64];
        int n2 = 0;
        for (n = 65; n <= 90; n = (int)((char)(n + 1))) {
            f.a[n2++] = n;
        }
        for (n = 97; n <= 122; n = (int)((char)(n + 1))) {
            f.a[n2++] = n;
        }
        for (n = 48; n <= 57; n = (int)((char)(n + 1))) {
            f.a[n2++] = n;
        }
        f.a[n2++] = 43;
        f.a[n2++] = 47;
        a = new byte[128];
        for (n2 = 0; n2 < a.length; ++n2) {
            f.a[n2] = -1;
        }
        for (n2 = 0; n2 < 64; ++n2) {
            f.a[f.a[n2]] = (byte)n2;
        }
    }

    public static void a(int n) {
        int n2 = (int)a.a((short)1, 200, 2L);
        j.a(n, n2, false);
    }

    public static void b(int n) {
        int n2 = (int)a.a((short)1, 300, 2L);
        j.a(n, n2, true);
    }

    public static String a(byte[] byArray) {
        return f.a(byArray, 0, byArray.length);
    }

    public static String a(byte[] byArray, int n, int n2) {
        int n3 = (n2 * 4 + 2) / 3;
        int n4 = (n2 + 2) / 3 * 4;
        char[] cArray = new char[n4];
        int n5 = 0;
        n2 += n;
        while (n < n2) {
            int n6 = byArray[n++] & 0xFF;
            int n7 = n < n2 ? byArray[n++] & 0xFF : 0;
            int n8 = n < n2 ? byArray[n++] & 0xFF : 0;
            cArray[n5++] = a[n6 >> 2];
            cArray[n5++] = a[n6 << 4 & 0x3F | n7 >> 4];
            cArray[n5] = n5 < n3 ? a[n7 << 2 & 0x3F | n8 >> 6] : 61;
            int n9 = ++n5 < n3 ? a[n8 & 0x3F] : 61;
            cArray[n5] = n9;
            ++n5;
        }
        return new String(cArray);
    }
}
