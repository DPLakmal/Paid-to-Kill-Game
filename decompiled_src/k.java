/*
 * Decompiled with CFR 0.152.
 */
import java.util.Random;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class k {
    private static Random a;
    private static int b;
    private static int c;
    private static int d;
    private static Object a;
    private static int e;
    private boolean b = false;
    private boolean c = true;
    private n a;
    public int a;
    public boolean a = false;
    public static d a;
    public static k a;
    public static byte[] a;
    public static short a;
    public static final int[] a;
    private static boolean d;
    private boolean e = false;
    public static byte a;

    public k() {
        a = this;
        a = new Random(System.currentTimeMillis());
    }

    private e a(int n2) {
        e e2 = new e((String)(n2 == -1 ? "Language" : b.a(9)), -1);
        e2.a(0, (String)(n2 == -1 ? "OK" : b.a(0)), 4, -1);
        if (n2 >= 0) {
            e2.a(1, (String)b.a(2), 1, 1);
        }
        String[] stringArray = b.a();
        String string = System.getProperty("microedition.locale");
        if (string != null) {
            string = string.substring(0, 2);
        }
        for (int i = 0; i < stringArray.length; ++i) {
            int n3 = stringArray[i].indexOf(59);
            if (n3 == -1) {
                n3 = stringArray[i].length();
            }
            e2.a(new c(stringArray[i].substring(0, n3), e2.i, 3), -1);
            if (i != n2 && (n3 >= stringArray[i].length() || n2 != -1 || !stringArray[i].substring(n3 + 1).startsWith(string))) continue;
            e2.f(i);
            n2 = i;
        }
        return e2;
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public final void a(int n2) {
        switch (n2) {
            case 1: {
                i.a(false);
                try {
                    b = h.a("langPTK")[0];
                }
                catch (Exception exception) {
                    b = -1;
                }
                h.a(b == -1 ? 3 : 5, this);
                b.a(0);
                Object object = a;
                synchronized (object) {
                    c = 4;
                    if (d == 5) {
                        h.a(8, this);
                    }
                }
                b.a(8);
                e.a(this);
                e.a = 297;
                e.e = 298;
                this.e();
                object = a;
                synchronized (object) {
                    while (d <= 4) {
                        try {
                            a.wait();
                        }
                        catch (InterruptedException interruptedException) {}
                    }
                }
                if (i.a()) {
                    this.d();
                }
                object = a;
                synchronized (object) {
                    c = 5;
                    while (d < 7) {
                        try {
                            a.wait();
                        }
                        catch (InterruptedException interruptedException) {}
                    }
                    this.b(-1);
                    while (!(h.a() instanceof e)) {
                        try {
                            Thread.sleep(50L);
                        }
                        catch (InterruptedException interruptedException) {}
                    }
                    b.c(0);
                    return;
                }
            }
            case 2: {
                this.c = false;
                if (this.a == 1) {
                    this.b = true;
                    return;
                }
                this.b = false;
                if (this.a == 3) {
                    d.d();
                    this.a = null;
                } else {
                    this.a = h.a();
                }
                h.a(null);
                i.a();
                return;
            }
            case 3: {
                if (this.b) {
                    return;
                }
                if (this.a == 3) {
                    h.a(13, this);
                    return;
                }
                this.b(-1);
                return;
            }
            case 4: {
                i.a();
                k.a();
            }
        }
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public final void a(int n2, Object object) {
        d = false;
        e e2 = null;
        if (object instanceof e) {
            e2 = (e)object;
        }
        switch (n2) {
            case 12: {
                h.a();
                return;
            }
            case 2: {
                int n3 = e2.a(e2.f);
                i.a(n3 == 1);
                if (i.a()) {
                    h.a(a.a(-1));
                    this.d();
                    i.a(-1, -1);
                    h.a(e2);
                }
                return;
            }
            case 3: {
                h.a(this.a(b));
                return;
            }
            case 4: {
                b = e2.f;
                try {
                    h.a(new byte[]{(byte)b}, "langPTK");
                }
                catch (Exception exception) {}
            }
            case 5: {
                h.a(a.a(-1));
                b.a(b);
                b.b(0);
                b.a(0);
                if (c == 5) {
                    h.a(e.a(1));
                    return;
                }
                Object object2 = a;
                synchronized (object2) {
                    d = 3;
                    d = 4;
                    h.a(e.a(5));
                    return;
                }
            }
            case 6: 
            case 7: {
                Object object3 = a;
                synchronized (object3) {
                    i.a(n2 == 6);
                    d = 5;
                    a.notify();
                    e = c == 4 ? 0 : -1;
                }
            }
            case 8: {
                Object object3;
                if (e < 2) {
                    d = 6;
                    object3 = new int[]{-1, 296, 295};
                    int[] nArray = new int[]{0xFFFFFF, 0xFFFFFF, 0};
                    int[] nArray2 = new int[]{0, 2000, 3000};
                    a a2 = e == 1 ? a.a((int)object3[e], nArray[e]) : a.b((int)object3[++e], nArray[e]);
                    if (e > 0) {
                        a2.a = 8;
                        a2.a = true;
                        a2.a(nArray2[e]);
                    }
                    h.a(a2);
                    return;
                }
                if (h.a() instanceof a) {
                    ((a)h.a()).a = -1;
                }
                object3 = a;
                synchronized (object3) {
                    d = 7;
                    if (c == 5) {
                        a.notify();
                    }
                    return;
                }
            }
            case 10: 
            case 11: {
                if (n2 == 11) {
                    this.a = e.a(3);
                    d = true;
                } else {
                    this.a = e.a(2);
                    d = true;
                }
            }
            case 13: {
                this.a = 1;
                h.a(a.a(-1));
                if (n2 != 10 && n2 != 11) {
                    i.a();
                }
                while (!(h.a() instanceof a)) {
                    try {
                        Thread.sleep(50L);
                    }
                    catch (InterruptedException interruptedException) {}
                }
                this.f();
                this.b(n2);
                return;
            }
            case 19: {
                this.c();
                h.a(11, null);
                return;
            }
            case 14: 
            case 17: {
                int n4;
                this.a = 1;
                if (n2 == 14) {
                    this.a = false;
                    n4 = a;
                } else {
                    n4 = d.A;
                }
                if (n4 == 10) {
                    this.c();
                    h.a(e.a(7));
                    return;
                }
                this.f(n4);
                this.c(n4);
                return;
            }
            case 21: {
                return;
            }
            case 18: {
                h.a(e.a(4));
                return;
            }
            case 20: {
                h.a(a.a(-1));
                h.a(e.a(6));
            }
        }
    }

    private void c() {
        h.a(a.a(-1));
        a = 0;
        a = 0;
        k.a[0] = 0;
        k.a[1] = 0;
        k.a[2] = 0;
        k.a[3] = 0;
        this.a = false;
        if (a != null) {
            d.A = 0;
            d.b = 0;
            d.a[0] = 0;
            d.a[1] = 0;
            d.a[2] = 0;
            d.a[3] = 0;
        }
        k.a();
    }

    public final void a(e e2, int n2) {
        if (n2 == 0) {
            if (d) {
                d = false;
                i.a(-1, -1);
            }
            if (!this.a) {
                if (a != 0) {
                    e2.a(1, (String)b.a(18));
                } else {
                    e2.a(2);
                }
                e2.a(0);
            } else {
                e2.a(1);
            }
            e2.f(0);
        }
        if (n2 == 3) {
            int n3 = 0;
            int n4 = 0;
            boolean bl = false;
            switch (a) {
                case 0: {
                    n3 = 26;
                    n4 = 37;
                    break;
                }
                case 1: {
                    n3 = 27;
                    n4 = 38;
                    break;
                }
                case 2: {
                    n3 = 28;
                    n4 = 39;
                    break;
                }
                case 3: {
                    n3 = 29;
                    n4 = 40;
                    break;
                }
                case 4: {
                    n3 = 30;
                    n4 = 41;
                    break;
                }
                case 5: {
                    n3 = 31;
                    n4 = 42;
                    break;
                }
                case 6: {
                    n3 = 32;
                    n4 = 43;
                    break;
                }
                case 7: {
                    n3 = 33;
                    n4 = 44;
                    break;
                }
                case 8: {
                    n3 = 34;
                    n4 = 45;
                    break;
                }
                case 9: {
                    n3 = 35;
                    n4 = 46;
                    break;
                }
                case 10: {
                    n3 = 36;
                    n4 = 47;
                    e2.g(1);
                    e2.a((String)null, 1);
                }
            }
            e2.b((String)b.a(n3), -1);
            e2.a(0, (String)b.a(n4));
        }
        if (n2 == 1) {
            e2.a(new c((String)b.a(9), e2.i, 3), 3);
            e2.a(0, i.a() ? 1 : 0);
        }
        if (n2 == 7) {
            e2.a(0, b.a(19, new String[]{"v1.21"}));
        }
    }

    public static final void a(int n2, String[] stringArray) {
        Object object = stringArray == null ? b.a(n2) : b.a(n2, stringArray);
        c[] cArray = new c[1];
        c[] cArray2 = cArray;
        cArray[0] = new c((String)object, n.b * 80 / 100, 2);
        l l2 = new l(cArray2, cArray2[0].c, a, (String)b.a(3));
        d.a = l2;
        h.a(l2);
        d.z = 0;
        d.c = true;
        d.e = true;
    }

    public static final void a(int n2, int n3, int n4, int n5, int n6, int n7) {
        l l2;
        String[] stringArray = new String[]{Integer.toString(n2), Integer.toString(n6), Integer.toString(n3), Integer.toString(n7), Integer.toString(n5), Integer.toString(n4), Integer.toString(n2 + n3 + n4 + n5)};
        if (d.A != 9) {
            c[] cArray = new c[1];
            c[] cArray2 = cArray;
            cArray[0] = new c(b.a(55, stringArray), n.b, 2);
            l2 = new l(cArray2, cArray2[0].c, a, (String)b.a(3));
        } else {
            c[] cArray = new c[1];
            c[] cArray3 = cArray;
            cArray[0] = new c((String)b.a(56), n.b, 2);
            l2 = new l(cArray3, cArray3[0].c, a, (String)b.a(3));
        }
        d.a = l2;
        h.a(l2);
        d.z = 0;
        d.c = true;
        d.e = true;
    }

    private void d() {
        if (this.e) {
            return;
        }
        this.e = true;
        b.a(4);
        short[] sArray = b.a(4);
        for (int j = 0; j < sArray.length; ++j) {
            i.a((byte[])b.b(sArray[j]), (int)sArray[j]);
        }
        b.c(4);
    }

    private void e() {
        try {
            byte[] byArray = h.a("gamePTK");
            a = byArray[0];
            a = (short)(((byArray[1] & 0xFF) << 8) + (byArray[2] & 0xFF));
            k.a[0] = byArray[3];
            k.a[1] = byArray[4];
            k.a[2] = byArray[5];
            k.a[3] = byArray[6];
            return;
        }
        catch (Exception exception) {
            a = 0;
            k.a[0] = 0;
            k.a[1] = 0;
            k.a[2] = 0;
            k.a[3] = 0;
            return;
        }
    }

    public static final void a() {
        byte[] byArray = new byte[]{a, (byte)(a >> 8), (byte)a, a[0], a[1], a[2], a[3]};
        try {
            h.a(byArray, "gamePTK");
            return;
        }
        catch (Exception exception) {
            return;
        }
    }

    private void b(int n2) {
        if (this.c && n2 != 10 && n2 != 11) {
            i.a(-1, -1);
        }
        if (this.a == null) {
            h.a(e.a(0));
        } else {
            h.a(this.a);
            this.a = null;
        }
        this.c = true;
        this.a = 2;
        this.b = false;
    }

    private void c(int n2) {
        if (this.b) {
            h.a(13, this);
            return;
        }
        if (!this.a) {
            d.a(n2);
            d.c();
            this.a = true;
            if (n2 == 0 && this.c) {
                i.a(a[d.A], -1);
            }
        } else {
            d.c();
            d.e();
            if (this.c && d.d == 1) {
                if (d.f == 0) {
                    i.a(a[d.A], -1);
                } else {
                    i.a(9, 1);
                }
            }
        }
        k.b();
        h.a(d.a);
        d.z = 0;
        d.c = true;
        d.e = true;
        this.a = 3;
    }

    public static final void b() {
        a.a(null, 0);
        a.a(null, 1);
        if (d.d == 1) {
            return;
        }
        a.a((String)b.a(3), 0);
        a.a((String)b.a(6), 1);
    }

    private void d(int n2) {
        if (!this.a) {
            d.f(n2);
        }
    }

    private void e(int n2) {
        System.gc();
        switch (n2) {
            case 1: 
            case 4: 
            case 8: {
                b.a(2);
                return;
            }
            case 0: 
            case 5: 
            case 6: 
            case 9: {
                b.a(3);
                return;
            }
        }
        b.a(1);
    }

    private void f() {
        d.b();
        b.c(1);
        b.c(2);
        b.c(3);
        System.gc();
    }

    private void f(int n2) {
        h.a(a.a(-1));
        i.a();
        while (!(h.a() instanceof a)) {
            try {
                Thread.sleep(50L);
            }
            catch (InterruptedException interruptedException) {}
        }
        if (a == null) {
            a = new d();
        }
        this.d(n2);
        this.e(n2);
    }

    public static final int a() {
        return a.nextInt();
    }

    static {
        b = -1;
        c = 1;
        d = 1;
        a = new Object();
        e = -1;
        a = null;
        a = new byte[4];
        a = new int[]{-1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
        int[] nArray = new int[]{-1, -1, -1, -1, -1, -1};
        boolean[] blArray = new boolean[]{true, true, true, true, true, true};
        int[] nArray2 = new int[]{0, 0, 0, 0, 0, 0};
        int[] nArray3 = new int[]{1, 1, 1, 1, 1, 1};
        a = 0;
    }
}
