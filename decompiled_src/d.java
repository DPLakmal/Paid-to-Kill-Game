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
public final class d
extends n {
    public static int a;
    public static int e;
    public static int f;
    public static int g;
    public static byte[] a;
    public static final int[] a;
    public static int h;
    public static int i;
    public static int j;
    public static int k;
    public static int l;
    public static int m;
    public static int n;
    public static int o;
    public static int p;
    public static int q;
    public static int r;
    public static int s;
    public static int t;
    public static int u;
    public static int v;
    public static int w;
    public static final byte[] b;
    public static final byte[] c;
    public static final byte[] d;
    public static final byte[] e;
    public static final byte[] f;
    public static final int[] b;
    public static boolean[] a;
    public static byte a;
    public static short[] a;
    public static byte[] g;
    public static short[] b;
    public static short[] c;
    public static byte[] h;
    public static short a;
    public static int x;
    public static int y;
    public static int z;
    private static boolean g;
    public static int A;
    private static boolean h;
    private static boolean i;
    public static byte[] i;
    public static byte[] j;
    public static m a;
    public static byte[] k;
    public static byte b;
    public static byte c;
    private static int J;
    private static int K;
    private static int L;
    private static int M;
    private static byte g;
    private static byte h;
    private static byte i;
    private static byte j;
    private static byte k;
    private static byte l;
    public static boolean a;
    public static short b;
    private static byte m;
    private static short c;
    private static byte n;
    private static byte o;
    private static boolean j;
    private static boolean k;
    private static boolean l;
    private static int N;
    private static int O;
    private static byte p;
    private static int P;
    private static boolean m;
    private static boolean n;
    private static byte q;
    private static byte r;
    private static int Q;
    private static int R;
    private static short d;
    private static int S;
    private static int T;
    private static boolean o;
    private static byte s;
    private static boolean p;
    public static boolean b;
    private static boolean q;
    private static boolean r;
    private static boolean s;
    private static byte t;
    private static byte u;
    private static byte[] l;
    private static byte[] m;
    private static byte[] n;
    private static byte[] o;
    private static byte[] p;
    private static byte[] q;
    private static byte[][] a;
    private static byte[] r;
    private static byte[][] b;
    private static int[] e;
    private static int[] f;
    private static int[] g;
    private static int[] h;
    private static byte[] s;
    private static byte[] t;
    private static byte[] u;
    private static byte[] v;
    private static byte[] w;
    private static byte[] x;
    private static byte[] y;
    private static byte[] z;
    private static byte[] A;
    private static byte[] B;
    private static byte[] C;
    private static byte[] D;
    private static byte[] E;
    private static byte[] F;
    private static byte[] G;
    private static boolean[] c;
    private static boolean[] d;
    private static boolean[] e;
    private static byte[] H;
    private static int[] i;
    private static int[] j;
    private static byte[] I;
    private static byte[][] c;
    private static byte[][] d;
    private static byte[][] e;
    private static byte[] J;
    private static int[] k;
    private static byte[] K;
    private static short[] d;
    private static byte v;
    private static byte w;
    private static byte x;
    private static boolean t;
    private static boolean[] f;
    private static byte y;
    private static byte[] L;
    private static byte[] M;
    private static byte[] N;
    private static byte[] O;
    private static short[] e;
    private static byte[] P;
    private static byte[] Q;
    private static boolean[] g;
    private static byte z;
    private static byte A;
    private static byte B;
    private static int[] l;
    public static boolean c;
    public static int B;
    private static boolean u;
    private static byte[] R;
    private static boolean v;
    private static boolean w;
    private static int U;
    public static boolean[] b;
    public static int[] c;
    public static boolean d;
    public static byte d;
    public static byte e;
    public static int C;
    public static int D;
    private static boolean x;
    private static boolean y;
    private static byte C;
    private static byte D;
    private static byte E;
    private static int V;
    private static boolean z;
    private static boolean A;
    public static boolean e;
    public static int E;
    private static byte F;
    public static n a;
    public static boolean f;
    public static byte f;
    private static byte G;
    private static byte H;
    private static byte I;
    private static short e;
    private static boolean B;
    private static short f;
    private static byte[] S;
    private static byte J;
    private static byte K;
    public static int F;
    public static int G;
    public static Font a;
    public static int[] d;
    public static int H;
    public static int I;

    public d() {
        d.f();
        f = 4;
        g = 5;
        int n2 = v - 200;
        int n3 = w - 240 + 20;
        if (n2 > 0) {
            v -= n2;
            t = n2 >> 1;
        }
        if (n3 > 0) {
            w -= n3;
            u = n3 >> 1;
        }
        if (w % 2 != 0) {
            --w;
        }
        a = new byte[4];
    }

    private static void f() {
        h = 58;
        i = 69;
        j = 63;
        k = 74;
        l = 56;
        m = 67;
        n = 61;
        o = 72;
        p = 57;
        q = 68;
        r = 62;
        s = 73;
    }

    public static final int a(byte by, byte by2) {
        if (by < 0 || by >= b || by2 < 0 || by2 >= c) {
            return -1;
        }
        return k[by2 * b + by] & 0xFF;
    }

    public static final int a(int n2) {
        return k[n2] & 0xFF;
    }

    public static final int b(byte by, byte by2) {
        return j[d.a(by, by2) - B << 1] & 0xFF;
    }

    public static final int b(int n2) {
        return j[n2 - B << 1] & 0xFF;
    }

    public static final int c(byte by, byte by2) {
        return j[(d.a(by, by2) - B << 1) + 1] & 0xFF;
    }

    public static final int c(int n2) {
        return j[(n2 - B << 1) + 1] & 0xFF;
    }

    public static final void a(byte by, byte by2, int n2) {
        d.k[by2 * d.b + by] = (byte)n2;
    }

    public static final void a(int n2, int n3) {
        d.k[n2] = (byte)n3;
    }

    /*
     * WARNING - void declaration
     */
    private static void g(int n2) {
        byte by;
        int n3;
        int n4;
        int n5;
        byte by3;
        int n6;
        v = false;
        q = false;
        boolean bl = b;
        boolean bl2 = false;
        boolean bl3 = false;
        for (n6 = 0; n6 < v; ++n6) {
            if (C[n6] == 0 || B[n6] != 0) continue;
            q = true;
            break;
        }
        if (!q && f == 1) {
            i.a(k.a[A], -1);
            f = 0;
        }
        if (u) {
            if (o == 0) {
                k = !k;
            } else if (o == 1) {
                if (o) {
                    byte by2;
                    byte by22;
                    o = false;
                    if (a[3] == 0) {
                        o = 0;
                        c = true;
                    }
                    S = 1;
                    byte by4 = (byte)(q - 1);
                    by3 = by4;
                    if (by4 < 0) {
                        by3 = 0;
                    }
                    if ((by22 = (byte)(q + 1)) >= b) {
                        by2 = (byte)(b - 1);
                    }
                    byte by5 = (byte)(r - 1);
                    n5 = by5;
                    if (by5 < 0) {
                        n5 = 0;
                    }
                    byte by6 = (byte)(r + 1);
                    n4 = by6;
                    if (by6 >= c) {
                        n4 = (byte)(c - 1);
                    }
                    for (n3 = n5; n3 <= n4; n3 = (byte)(n3 + 1)) {
                        for (by = by3; by <= by2; by = (byte)((byte)(by + 1))) {
                            byte by7 = d.b(by, (byte)n3, q, r);
                            n6 = by7;
                            if (by7 > 1 || n6 == -1 || (i[d.a(by, (byte)n3)] & 4) == 0 || (i[d.a(by, (byte)n3)] & 1) != 0) continue;
                            d.a(by, (byte)n3, d.b(by, (byte)n3));
                            a.a(by * 10, n3 * 10, by * 10 + 10, n3 * 10 + 10, l[0], l[1]);
                            if (n3 <= 0 || (i[d.a(by, (byte)(n3 - 1))] & 1) == 0 || (i[d.a(by, (byte)(n3 - 1))] & 4) == 0) continue;
                            d.a(by, (byte)(n3 - 1), d.b(by, (byte)(n3 - 1)));
                            a.a(by * 10, (n3 - 1) * 10, by * 10 + 10, (n3 - 1) * 10 + 10, l[0], l[1]);
                        }
                    }
                    for (n3 = 0; n3 < v; ++n3) {
                        if (B[n3] == 1 || B[n3] == 3) continue;
                        byte by8 = d.b(s[n3], t[n3], q, r);
                        n6 = by8;
                        if (by8 > 1 || n6 == -1 || (by = (e[n6] + k.a() % 2) * 3) <= 0) continue;
                        int n7 = n3;
                        x[n7] = (byte)(x[n7] - by);
                        if (x[n3] > 0) continue;
                        d.n(n3);
                    }
                    byte by9 = d.b(g, h, q, r);
                    n6 = by9;
                    if (by9 <= 1 && n6 != -1 && (n3 = (e[n6] + k.a() % 2) * 3) > 0 && (k = (byte)(k - n3)) <= 0) {
                        d.g();
                    }
                    d.c(q, r);
                } else if (a[3] > 0 && !p) {
                    a[3] = (byte)(a[3] - 1);
                    o = true;
                    q = g;
                    r = h;
                    Q = J;
                    R = K;
                    S = 0;
                    s = 0;
                }
            } else if (o == 2 && m > 0 && k < l && !q) {
                f = 1;
                m = (byte)(m - 1);
                if ((k = (byte)(k + 10)) > l) {
                    k = l;
                }
            }
            u = false;
            c = true;
        }
        if (n && A != 6) {
            n6 = o;
            n = false;
            c = true;
            if ((o = (byte)(o + 1)) == 1 && a[3] < 1 && !o) {
                o = (byte)(o + 1);
            }
            if (o == 2 && m < 1) {
                o = (byte)(o + 1);
            }
            if (o == 3) {
                o = 0;
            }
            if (n6 != 0 || o != 0) {
                k = false;
            }
        }
        if (S > 0 && (S += n2) > 100) {
            S = 1;
            if ((s = (byte)(s + 1)) == g) {
                S = 0;
            }
        }
        if (f > 0 && (f = (short)(f + n2)) > 400) {
            f = 0;
            c = true;
            if (m == 0 && A != 6) {
                o = 0;
            }
        }
        if (t > 0 && (t = (byte)(t + n2)) > 80) {
            t = 1;
            if ((u = (byte)(u + 1)) >= 3) {
                u = 0;
                t = 0;
            }
        }
        if (C > 0 && (C += n2) > 1300) {
            C = 0;
        }
        if (T == 0) {
            void var6_11;
            int n8;
            if (z == 0) {
                j = false;
                return;
            }
            j = true;
            n6 = L;
            by3 = M;
            int n9 = L;
            n5 = M;
            n4 = c;
            n3 = 0;
            if ((N += n2) > 7000 / c) {
                N = 0;
                if ((p = (byte)(p + 1)) >= 4) {
                    p = 0;
                }
            }
            by = 0;
            if ((z & 4) != 0) {
                ++by;
            }
            if ((z & 8) != 0) {
                ++by;
            }
            if ((z & 1) != 0) {
                ++by;
            }
            if ((z & 2) != 0) {
                ++by;
            }
            if (by > 1) {
                n4 = n4 * 1000 / 1414;
            }
            if ((n8 = (n2 << 4) * n4) >= 589824) {
                n8 = 589824;
            }
            if ((z & 4) != 0) {
                int n10 = n9 - n8;
            } else if ((z & 8) != 0) {
                int n11 = n9 + n8;
            }
            if ((z & 1) != 0) {
                n5 -= n8;
            } else if ((z & 2) != 0) {
                n5 += n8;
            }
            byte by10 = (byte)(var6_11 / 10 >> 16);
            byte by11 = (byte)(n5 / 10 >> 16);
            byte by12 = (byte)(n6 / 10 >> 16);
            byte by13 = (byte)(by3 / 10 >> 16);
            if (p) {
                if ((z & 2) == 0) {
                    return;
                }
                d.a(by12, (byte)(by13 - 1), 10);
                p = false;
                r = false;
                w = true;
                a.a(by12 * 10, (by13 - 1) * 10, by12 * 10 + 10, (by13 - 1) * 10 + 10, l[0], l[1]);
            }
            if (n6 < var6_11 && by3 < n5) {
                i = (byte)3;
            } else if (n6 < var6_11 && by3 > n5) {
                i = 1;
            } else if (n6 > var6_11 && by3 < n5) {
                i = (byte)5;
            } else if (n6 > var6_11 && by3 > n5) {
                i = (byte)7;
            } else if (n6 < var6_11) {
                i = (byte)2;
            } else if (n6 > var6_11) {
                i = (byte)6;
            } else if (by3 < n5) {
                i = (byte)4;
            } else if (by3 > n5) {
                i = 0;
            }
            if (g != by10 || h != by11) {
                if (by10 < 0 || by10 >= b || by11 < 0 || by11 >= c) {
                    return;
                }
                if ((by11 <= by13 || d.a(by10, by11) != 7) && (by11 <= by13 || d.a(by10, by11) < B || d.c(by10, by11) != -1 && d.c(by10, by11) != -1 && d.c(by10, by11) != 71 && d.c(by10, by11) != 70)) {
                    d.a(by10, by11);
                }
                if ((i[d.a(by10, by11)] & 8) != 0 && z == 1) {
                    d.a(by10, by11, 7);
                    a.a(by10 * 10, by11 * 10, by10 * 10 + 10, by11 * 10 + 10, l[0], l[1]);
                    p = true;
                    if (!t) {
                        r = true;
                        if (A == 6 && F == 0) {
                            F = 1;
                            d.a(by10, by11);
                            F = (byte)2;
                        }
                    }
                }
                if ((i[d.a(by10, by11)] & 1) == 0) {
                    return;
                }
                if (d.a(by12, by13) == j || d.a(by12, by13) == k) {
                    bl2 = true;
                }
                v = true;
                w = true;
                b = (i[d.a(by10, by11)] & 2) != 0;
                l = false;
                int n12 = d.a(by10, by11);
                for (int j = 0; j < b.length; ++j) {
                    if (n12 >= B && d.b(n12) == b[j]) {
                        l = true;
                        break;
                    }
                    if (n12 != b[j]) continue;
                    l = true;
                    break;
                }
                if (w == by12 && x == by13) {
                    y = by12 < by10 ? (byte)2 : (by12 > by10 ? (byte)6 : (by13 < by11 ? (byte)4 : (byte)0));
                }
                if ((i[d.a(by10, by11)] & 0x10) != 0 && d == -1) {
                    d.a((int)by10, (int)by11, -1);
                } else if (d > -1 && (i[d.a(by10, by11)] & 0x10) == 0) {
                    d.b(d, -1);
                }
                if (d.a(by10, by11) == j || d.a(by10, by11) == k) {
                    bl3 = true;
                }
            }
            d.a(by10, by11, (int)var6_11, n5, true, -1);
            int n13 = c[0];
            n5 = c[1];
            L = n13;
            M = n5;
            J = L >> 16;
            K = M >> 16;
            g = by10;
            h = by11;
            if (d.a()) {
                a.b(l[2], l[3], l[0], l[1]);
            }
            if (bl3) {
                a = true;
                if (bl) {
                    a.a(l[0], l[1]);
                }
            } else if (bl2) {
                a = false;
                a.a(l[0], l[1]);
            }
            if (bl != b) {
                if (b) {
                    d.d(g, h);
                }
                a.a(l[0], l[1]);
            }
            return;
        }
        if ((T += n2) > 45) {
            if ((n = (byte)(n + 1)) >= 12) {
                d.h();
                return;
            }
            if ((i = (byte)(i + 1)) > 7) {
                i = 0;
            }
            T = 1;
        }
    }

    private static void a(byte by, byte by2) {
        for (int j = 0; j < A; ++j) {
            if (by < m[j] || by > o[j] || by2 < n[j] || by2 > p[j] || (q[j] & 2) == 0) continue;
            if (A == 6 && j == 14 && F == 0) {
                return;
            }
            if ((q[j] & 1) != 0) {
                int n2 = j;
                q[n2] = (byte)(q[n2] & 0xFFFFFFFD);
            }
            block14: for (int i2 = 0; i2 < a[j].length; i2 += 4) {
                switch (a[j][i2]) {
                    case 4: {
                        byte by3 = a[j][i2 + 1];
                        q[by3] = (byte)(q[by3] | 2);
                        continue block14;
                    }
                    case 5: {
                        byte by4 = a[j][i2 + 1];
                        q[by4] = (byte)(q[by4] & 0xFFFFFFFD);
                        continue block14;
                    }
                    case 2: {
                        if (m >= 9) continue block14;
                        m = (byte)(m + 1);
                        c = true;
                        continue block14;
                    }
                    case 6: {
                        d.c(g, h);
                        continue block14;
                    }
                    case 9: {
                        if (B[a[j][i2 + 1]] != 2) continue block14;
                        d.B[d.a[j][i2 + 1]] = 0;
                        continue block14;
                    }
                    case 10: {
                        if (B[a[j][i2 + 1]] != 0 || C[a[j][i2 + 1]] != 0) continue block14;
                        d.B[d.a[j][i2 + 1]] = 2;
                        continue block14;
                    }
                    case 0: {
                        byte by5 = a[j][i2 + 1];
                        byte by6 = a[j][i2 + 2];
                        if (A != 4 || j != 8 || i2 != 4) {
                            d.a(by5, by6, (int)a[j][i2 + 3]);
                        } else {
                            H = by5;
                            I = by6;
                            e = a[j][i2 + 3];
                        }
                        a.a(by5 * 10, by6 * 10, by5 * 10 + 10, by6 * 10 + 10, l[0], l[1]);
                        d.a(d.a(by5, by6), by5, (byte)(by6 - 1));
                        continue block14;
                    }
                    case 7: {
                        if (!d) continue block14;
                        i = true;
                        continue block14;
                    }
                    case 8: {
                        i = true;
                        continue block14;
                    }
                    case 3: {
                        byte by7 = a[j][i2 + 1];
                        byte by8 = a[j][i2 + 2];
                        byte by9 = a[j][i2 + 3];
                        if ((C[by7] != 0 || D[by7] == 6) && (A != 6 || F != 1)) continue block14;
                        d.a(s[by7], t[by7], by8, by9);
                        d.u[by7] = by8;
                        d.v[by7] = by9;
                        if (d.a((int)by7, by8, by9)) {
                            d.D[by7] = 6;
                            d.C[by7] = 0;
                            d.H[by7] = d.a(s[by7], t[by7], d[by7][w[by7]], e[by7][w[by7]]);
                            continue block14;
                        }
                        d.D[by7] = 5;
                        continue block14;
                    }
                    case 1: {
                        if (A == 5 && j == 20) {
                            G = 1;
                        }
                        d.i(a[j][i2 + 1] & 0xFF);
                    }
                }
            }
        }
    }

    private static void a(int n2, byte by, byte by2) {
        boolean bl = true;
        if (n2 == l) {
            d.a(by, by2, B + 1);
        } else if (n2 == m) {
            d.a(by, by2, B + 4);
        } else if (n2 == n) {
            d.a(by, by2, B + 7);
        } else if (n2 == o) {
            d.a(by, by2, B + 10);
        } else if (n2 == p) {
            d.a(by, by2, B + 2);
        } else if (n2 == q) {
            d.a(by, by2, B + 5);
        } else if (n2 == r) {
            d.a(by, by2, B + 8);
        } else if (n2 == s) {
            d.a(by, by2, B + 11);
        } else {
            bl = false;
        }
        if (bl) {
            a.a(by * 10, by2 * 10, by * 10 + 10, by2 * 10 + 10, l[0], l[1]);
        }
    }

    private static void h(int n2) {
        for (int j = 0; j < B; ++j) {
            if (r[j] != n2) continue;
            block13: for (int i2 = 0; i2 < b[j].length; i2 += 4) {
                switch (b[j][i2]) {
                    case 4: {
                        byte by = b[j][i2 + 1];
                        q[by] = (byte)(q[by] | 2);
                        continue block13;
                    }
                    case 5: {
                        byte by = b[j][i2 + 1];
                        q[by] = (byte)(q[by] & 0xFFFFFFFD);
                        continue block13;
                    }
                    case 2: {
                        if (m >= 9) continue block13;
                        m = (byte)(m + 1);
                        c = true;
                        continue block13;
                    }
                    case 6: {
                        d.c(g, h);
                        continue block13;
                    }
                    case 9: {
                        if (B[b[j][i2 + 1]] != 2) continue block13;
                        d.B[d.b[j][i2 + 1]] = 0;
                        continue block13;
                    }
                    case 10: {
                        if (B[b[j][i2 + 1]] != 0 || C[b[j][i2 + 1]] != 0) continue block13;
                        d.B[d.b[j][i2 + 1]] = 2;
                        continue block13;
                    }
                    case 0: {
                        byte by = b[j][i2 + 1];
                        byte by2 = b[j][i2 + 2];
                        d.a(by, by2, (int)b[j][i2 + 3]);
                        a.a(by * 10, by2 * 10, by * 10 + 10, by2 * 10 + 10, l[0], l[1]);
                        d.a(d.a(by, by2), by, (byte)(by2 - 1));
                        continue block13;
                    }
                    case 7: {
                        if (!d) continue block13;
                        i = true;
                        continue block13;
                    }
                    case 8: {
                        i = true;
                        continue block13;
                    }
                    case 1: {
                        d.i(b[j][i2 + 1] & 0xFF);
                    }
                }
            }
            return;
        }
    }

    private static void a(int n2, int n3, int n4) {
        short s = (short)(n3 * b + n2);
        int n5 = d.a(s);
        if (n5 == l) {
            d.a((int)s, h);
            d.a(s - b, B + 0);
        } else if (n5 == m) {
            d.a((int)s, i);
            d.a(s - b, B + 3);
        } else if (n5 == n) {
            d.a((int)s, j);
            d.a(s - b, B + 6);
        } else if (n5 == o) {
            d.a((int)s, k);
            d.a(s - b, B + 9);
        }
        a.a(n2 * 10, (n3 - 1) * 10, n2 * 10 + 10, n3 * 10 + 10, l[0], l[1]);
        if (n4 == -1) {
            d = s;
            return;
        }
        d.d[n4] = s;
    }

    private static void b(int n2, int n3) {
        int n4;
        boolean bl = false;
        for (n4 = 0; n4 < v; ++n4) {
            if (n4 == n3 || d[n4] != n2) continue;
            bl = true;
            break;
        }
        if (d == n2 && n3 != -1) {
            bl = true;
        }
        if (!bl) {
            n4 = d.a(n2);
            if (n4 == h) {
                d.a(n2, l);
                d.a(n2 - b, B + 1);
            } else if (n4 == i) {
                d.a(n2, m);
                d.a(n2 - b, B + 4);
            } else if (n4 == j) {
                d.a(n2, n);
                d.a(n2 - b, B + 7);
            } else if (n4 == k) {
                d.a(n2, o);
                d.a(n2 - b, B + 10);
            }
        }
        n4 = (byte)(n2 % b);
        byte by = (byte)(n2 / b);
        a.a(n4 * 10, (by - 1) * 10, n4 * 10 + 10, by * 10 + 10, l[0], l[1]);
        if (n3 == -1) {
            d = (short)-1;
            return;
        }
        d.d[n3] = -1;
    }

    private static void i(int n2) {
        if (((String)b.a(n2)).equals("")) {
            return;
        }
        if (H < d.length) {
            d.d[d.H] = n2;
            ++H;
        }
    }

    private static void b(byte by, byte by2) {
        if (by2 < 0 || z != 1) {
            return;
        }
        if ((i[d.a(by, by2)] & 8) != 0 && d.a(by, by2) != 10) {
            d.a(by, by2, 10);
            a.a(by * 10, by2 * 10, by * 10 + 10, by2 * 10 + 10, l[0], l[1]);
            d.a(by, by2);
        }
    }

    private static void g() {
        k = 0;
        if (T == 0) {
            i.a(-1, 1);
            T = 1;
        }
    }

    private static void h() {
        h = true;
    }

    private static void a(byte by, byte by2, int n2, int n3, boolean bl, int n4) {
        boolean bl2 = false;
        d.c[0] = n2;
        d.c[1] = n3;
        for (int j = 0; j < 8; ++j) {
            int n5;
            int n6;
            if (j == 0) {
                n6 = 0;
                n5 = -1;
            } else if (j == 1) {
                n6 = 1;
                n5 = 0;
            } else if (j == 2) {
                n6 = 0;
                n5 = 1;
            } else if (j == 3) {
                n6 = -1;
                n5 = 0;
            } else if (j == 4) {
                n6 = 1;
                n5 = 1;
            } else if (j == 5) {
                n6 = -1;
                n5 = 1;
            } else if (j == 6) {
                n6 = -1;
                n5 = -1;
            } else {
                n6 = 1;
                n5 = -1;
            }
            byte by3 = (byte)(by + n6);
            byte by4 = (byte)(by2 + n5);
            if (!d.a((int)by3, (int)by4, false) || by3 >= 0 && by3 < b && by4 >= 0 && by4 < c && (i[d.a(by3, by4)] & 0x40) == 0) continue;
            if (n6 == 0 && n5 == -1) {
                if (n3 >= (by4 * 10 + 10 << 16) + (f << 16)) continue;
                n3 = (by4 * 10 + 10 << 16) + (f << 16);
                bl2 = true;
                if (!bl) continue;
                d.b(by3, by4);
                if (by4 >= 0 && d.a(by3, by4) == 10) {
                    bl2 = false;
                }
                if (d.a(by3, by4) == 10 || d.a(by3, by4) == 7) continue;
                d.a(by3, by4);
                continue;
            }
            if (n6 == 1 && n5 == 0) {
                if (n2 <= (by3 * 10 << 16) - (f << 16)) continue;
                n2 = (by3 * 10 << 16) - (f << 16);
                bl2 = true;
                if (!bl || d.a(by3, by4) == 7) continue;
                d.a(by3, by4);
                continue;
            }
            if (n6 == 0 && n5 == 1) {
                if (n3 <= (by4 * 10 << 16) - (f << 16)) continue;
                n3 = (by4 * 10 << 16) - (f << 16);
                bl2 = true;
                if (d.a(by3, by4) == 7 || d.a(by3, by4) >= B && (d.c(by3, by4) == 71 || d.c(by3, by4) == 70)) continue;
                d.a(by3, by4);
                continue;
            }
            if (n6 == -1 && n5 == 0) {
                if (n2 >= (by3 * 10 + 10 << 16) + (f << 16)) continue;
                n2 = (by3 * 10 + 10 << 16) + (f << 16);
                bl2 = true;
                if (!bl || d.a(by3, by4) == 7) continue;
                d.a(by3, by4);
                continue;
            }
            if (n6 == 1 && n5 == 1) {
                if (n2 <= (by3 * 10 << 16) - (f << 16) || n3 <= (by4 * 10 << 16) - (f << 16)) continue;
                n2 = (by3 * 10 << 16) - (f << 16);
                n3 = (by4 * 10 << 16) - (f << 16);
                bl2 = true;
                if (d.a(by3, by4) == 7 || d.a(by3, by4) >= B && (d.c(by3, by4) == 71 || d.c(by3, by4) == 70)) continue;
                d.a(by3, by4);
                continue;
            }
            if (n6 == -1 && n5 == 1) {
                if (n2 >= (by3 * 10 + 10 << 16) + (f << 16) || n3 <= (by4 * 10 << 16) - (f << 16)) continue;
                n2 = (by3 * 10 + 10 << 16) + (f << 16);
                n3 = (by4 * 10 << 16) - (f << 16);
                bl2 = true;
                if (d.a(by3, by4) == 7 || d.a(by3, by4) >= B && (d.c(by3, by4) == 71 || d.c(by3, by4) == 70)) continue;
                d.a(by3, by4);
                continue;
            }
            if (n6 == -1 && n5 == -1) {
                if (n2 >= (by3 * 10 + 10 << 16) + (f << 16) || n3 >= (by4 * 10 + 10 << 16) + (f << 16)) continue;
                n2 = (by3 * 10 + 10 << 16) + (f << 16);
                n3 = (by4 * 10 + 10 << 16) + (f << 16);
                bl2 = true;
                if (!bl || d.a(by3, by4) == 7) continue;
                d.a(by3, by4);
                continue;
            }
            if (n6 != 1 || n5 != -1 || n2 <= (by3 * 10 << 16) - (f << 16) || n3 >= (by4 * 10 + 10 << 16) + (f << 16)) continue;
            n2 = (by3 * 10 << 16) - (f << 16);
            n3 = (by4 * 10 + 10 << 16) + (f << 16);
            bl2 = true;
            if (!bl || d.a(by3, by4) == 7) continue;
            d.a(by3, by4);
        }
        if (bl2) {
            d.c[0] = n2;
            d.c[1] = n3;
            return;
        }
    }

    private static void j(int n2) {
        boolean bl = false;
        for (int j = 0; j < v; ++j) {
            if (L[j] > 0) {
                int n3 = j;
                L[n3] = (byte)(L[n3] + n2);
                if (L[j] > 80) {
                    d.L[j] = 1;
                    int n4 = j;
                    M[n4] = (byte)(M[n4] + 1);
                    if (M[j] >= 3) {
                        d.M[j] = 0;
                        d.L[j] = 0;
                    }
                }
            }
            if (B[j] == 0) {
                byte by;
                int n5;
                byte by2;
                byte by3;
                int n6;
                byte by4 = H[j];
                d.e[j] = false;
                if (C[j] == 0) {
                    if (D[j] == 3) {
                        if (s[j] == d[j][w[j]] && t[j] == e[j][w[j]]) {
                            int n7 = j;
                            w[n7] = (byte)(w[n7] + 1);
                            if (w[j] >= J[j]) {
                                d.D[j] = 4;
                            } else {
                                d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                                d.b(j, Q[y[j]], n2);
                            }
                        } else {
                            d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                            d.b(j, Q[y[j]], n2);
                        }
                    } else if (D[j] == 0) {
                        d.H[j] = c[j][(A[j] << 2) + 3];
                        d.i[j] = 0;
                        d.D[j] = 1;
                    } else if (D[j] == 1) {
                        int n8 = j;
                        i[n8] = i[n8] + n2;
                        if (i[j] > c[j][(A[j] << 2) + 2] * 100) {
                            d.i[j] = 0;
                            int n9 = j;
                            A[n9] = (byte)(A[n9] + 1);
                            if (A[j] >= c[j].length >> 2) {
                                d.A[j] = 0;
                            }
                            if (s[j] == c[j][A[j] << 2] && t[j] == c[j][(A[j] << 2) + 1]) {
                                d.D[j] = 0;
                            } else {
                                d.H[j] = d.a(s[j], t[j], c[j][A[j] << 2], c[j][(A[j] << 2) + 1]);
                                d.D[j] = 2;
                            }
                        }
                    } else if (D[j] == 2) {
                        d.H[j] = d.a(s[j], t[j], c[j][A[j] << 2], c[j][(A[j] << 2) + 1]);
                        d.b(j, Q[y[j]], n2);
                        if (s[j] == c[j][A[j] << 2] && t[j] == c[j][(A[j] << 2) + 1]) {
                            d.D[j] = 0;
                        }
                    } else if (D[j] == 4) {
                        if (s[j] == c[j][A[j] << 2] && t[j] == c[j][(A[j] << 2) + 1]) {
                            d.D[j] = 0;
                        } else if (!bl) {
                            bl = true;
                            n6 = 9999;
                            by3 = 0;
                            for (by2 = 0; by2 < c[j].length >> 2; by2 = (byte)(by2 + 1)) {
                                short s = (short)(Math.abs(c[j][by2 << 2] - d.s[j]) + Math.abs(c[j][(by2 << 2) + 1] - t[j]));
                                n5 = s;
                                if (s >= n6) continue;
                                n6 = n5;
                                by3 = by2;
                            }
                            d.A[j] = by3;
                            d.a(s[j], t[j], c[j][A[j] << 2], c[j][(A[j] << 2) + 1]);
                            if (d.a(j, c[j][A[j] << 2], c[j][(A[j] << 2) + 1])) {
                                d.D[j] = 3;
                                d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                            } else {
                                d.D[j] = 5;
                            }
                        }
                    } else if (D[j] == 6) {
                        if (s[j] == d[j][w[j]] && t[j] == e[j][w[j]]) {
                            int n10 = j;
                            w[n10] = (byte)(w[n10] + 1);
                            if (w[j] >= J[j]) {
                                if (s[j] == u[j] && t[j] == v[j]) {
                                    d.D[j] = 4;
                                } else {
                                    d.a(s[j], t[j], u[j], v[j]);
                                    if (d.a(j, u[j], v[j])) {
                                        d.D[j] = 6;
                                        d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                                    } else {
                                        d.D[j] = 5;
                                    }
                                }
                            } else {
                                d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                                d.b(j, Q[y[j]], n2);
                            }
                        } else {
                            d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                            d.b(j, Q[y[j]], n2);
                        }
                    } else if (D[j] == 5) {
                        // empty if block
                    }
                } else if (C[j] == 2) {
                    if (F[j] == 5) {
                        int n11 = j;
                        i[n11] = i[n11] + n2;
                        if (i[j] > 800) {
                            d.i[j] = 0;
                            d.F[j] = 0;
                            d.c(j, 2);
                            i.a(9, 1);
                            f = 1;
                        }
                    } else if (F[j] == 3) {
                        int n12 = j;
                        i[n12] = i[n12] + n2;
                        if (i[j] > 800) {
                            d.i[j] = 0;
                            d.F[j] = 0;
                        }
                    } else if (R[j] != -1 && !s) {
                        d.F[j] = 0;
                    } else if (F[j] == 0) {
                        if (!bl) {
                            bl = true;
                            int n13 = 0;
                            int n14 = 0;
                            if (!t) {
                                if (y == 0) {
                                    if (x - 2 > -1 && (i[d.a(w, (byte)(x - 2))] & 1) != 0 && (i[d.a(w, (byte)(x - 2 + 1))] & 1) != 0) {
                                        n14 = -2;
                                    }
                                } else if (y == 4) {
                                    if (x + 2 < c && (i[d.a(w, (byte)(x + 2))] & 1) != 0 && (i[d.a(w, (byte)(x + 2 - 1))] & 1) != 0) {
                                        n14 = 2;
                                    }
                                } else if (y == 6) {
                                    if (w - 2 > -1 && (i[d.a((byte)(w - 2), x)] & 1) != 0 && (i[d.a((byte)(w - 2), x)] & 1) != 0) {
                                        n13 = -2;
                                    }
                                } else if (y == 2 && w + 2 < b && (i[d.a((byte)(w + 2), x)] & 1) != 0 && (i[d.a((byte)(w + 2 - 1), x)] & 1) != 0) {
                                    n13 = 2;
                                }
                            }
                            n6 = 0;
                            n5 = 0;
                            by3 = 0;
                            while (by3 == 0) {
                                n6 = k.a() % 2;
                                n5 = k.a() % 2;
                                by2 = (byte)(w + n13 + n6);
                                by = (byte)(x + n14 + n5);
                                if (by2 < 0 || by2 >= b || by < 0 || by >= c || (i[d.a(by2, by)] & 1) == 0) continue;
                                by3 = 1;
                            }
                            d.a(s[j], t[j], (byte)(w + n13 + n6), (byte)(x + n14 + n5));
                            if (d.a(j, (byte)(w + n13 + n6), (byte)(x + n14 + n5))) {
                                d.F[j] = 1;
                                d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                            } else {
                                d.F[j] = 2;
                            }
                        }
                    } else if (F[j] == 1) {
                        if (v) {
                            d.F[j] = 0;
                        } else if (s[j] == d[j][w[j]] && t[j] == e[j][w[j]]) {
                            int n15 = j;
                            w[n15] = (byte)(w[n15] + 1);
                            if (w[j] >= J[j]) {
                                if (t) {
                                    d.F[j] = 0;
                                } else {
                                    d.i[j] = 0;
                                    d.G[j] = 0;
                                    d.F[j] = 4;
                                }
                            } else {
                                d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                                d.b(j, P[y[j]], n2);
                            }
                        } else {
                            d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                            d.b(j, P[y[j]], n2);
                        }
                    } else if (F[j] == 4) {
                        int n16 = j;
                        i[n16] = i[n16] + n2;
                        if (i[j] > 400) {
                            int n17 = j;
                            G[n17] = (byte)(G[n17] + 1);
                            if (G[j] == 8) {
                                for (n6 = 0; n6 < v; ++n6) {
                                    if (C[n6] != 2 && C[n6] != 1) continue;
                                    d.C[n6] = 0;
                                    d.D[n6] = 4;
                                }
                            } else {
                                int n18 = j;
                                H[n18] = (byte)(H[n18] + 1);
                                if (H[j] > 7) {
                                    d.H[j] = 0;
                                }
                                d.i[j] = 0;
                            }
                        }
                    } else if (F[j] == 2 && v) {
                        d.F[j] = 0;
                    }
                } else if (C[j] == 1) {
                    if (E[j] == 5) {
                        int n19 = j;
                        i[n19] = i[n19] + n2;
                        if (i[j] > 800) {
                            d.i[j] = 0;
                            d.E[j] = 0;
                            d.c(j, 1);
                        }
                    } else if (E[j] == 1) {
                        int n20 = j;
                        i[n20] = i[n20] + n2;
                        if (i[j] > 800) {
                            d.i[j] = 0;
                            d.E[j] = 0;
                        }
                    } else if (E[j] == 0) {
                        if (!bl) {
                            bl = true;
                            n6 = 0;
                            n5 = 0;
                            by3 = 0;
                            while (by3 == 0) {
                                n6 = k.a() % 2;
                                n5 = k.a() % 2;
                                by2 = (byte)(w + n6);
                                by = (byte)(x + n5);
                                if (by2 < 0 || by2 >= b || by < 0 || by >= c || (i[d.a(by2, by)] & 1) == 0) continue;
                                by3 = 1;
                            }
                            d.a(s[j], t[j], (byte)(w + n6), (byte)(x + n5));
                            if (d.a(j, w, x)) {
                                d.E[j] = 2;
                                d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                            } else {
                                d.E[j] = 3;
                            }
                        }
                    } else if (E[j] == 2) {
                        if (s[j] == d[j][w[j]] && t[j] == e[j][w[j]]) {
                            int n21 = j;
                            w[n21] = (byte)(w[n21] + 1);
                            if (w[j] >= J[j]) {
                                d.i[j] = 0;
                                d.G[j] = 0;
                                d.E[j] = 4;
                            } else {
                                d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                                d.b(j, Q[y[j]], n2);
                            }
                        } else {
                            d.H[j] = d.a(s[j], t[j], d[j][w[j]], e[j][w[j]]);
                            d.b(j, Q[y[j]], n2);
                        }
                    } else if (E[j] == 4) {
                        int n22 = j;
                        i[n22] = i[n22] + n2;
                        if (i[j] > 400) {
                            int n23 = j;
                            G[n23] = (byte)(G[n23] + 1);
                            if (G[j] == 8) {
                                for (n6 = 0; n6 < v; ++n6) {
                                    if (C[n6] != 1) continue;
                                    d.C[n6] = 0;
                                    d.D[n6] = 4;
                                }
                            } else {
                                int n24 = j;
                                H[n24] = (byte)(H[n24] + 1);
                                if (H[j] > 7) {
                                    d.H[j] = 0;
                                }
                                d.i[j] = 0;
                            }
                        }
                    }
                }
                if (H[j] == by4) continue;
                w = true;
                continue;
            }
            if (B[j] != 3) continue;
            int n25 = j;
            i[n25] = i[n25] + n2;
            if (i[j] <= 45) continue;
            int n26 = j;
            G[n26] = (byte)(G[n26] + 1);
            if (G[j] >= 12) {
                d.o(j);
                continue;
            }
            int n27 = j;
            H[n27] = (byte)(H[n27] + 1);
            if (H[j] > 7) {
                d.H[j] = 0;
            }
            d.i[j] = 0;
        }
    }

    private static void c(int n2, int n3) {
        if (n3 == 2 && !g[y[n2]]) {
            E = (byte)(E + 1);
        }
        for (int j = 0; j < e; ++j) {
            d.b[j] = false;
        }
        d.a((int)s[n2], (int)t[n2], 5, 5, n3, n2);
    }

    private static void c(byte by, byte by2) {
        w = by;
        x = by2;
        for (int j = 0; j < e; ++j) {
            d.b[j] = false;
        }
        d.a((int)by, (int)by2, 5, 5, 1, -1);
    }

    private static void d(int n2, int n3) {
        for (int j = 0; j < b * c; ++j) {
            d.a[j] = false;
        }
        a = 0;
        d.e(n2, n3);
    }

    private static void e(int n2, int n3) {
        if (n2 < 0 || n2 >= b) {
            return;
        }
        if (n3 < 0 || n3 >= c) {
            return;
        }
        int n4 = d.a((byte)n2, (byte)n3);
        if (!a[n3 * b + n2] && ((i[n4] & 2) != 0 || n4 >= B && (i[d.c(n4)] & 2) != 0)) {
            d.a[n3 * d.b + n2] = true;
            if (n3 > a) {
                a = (byte)n3;
            }
            d.e(n2 + 1, n3);
            d.e(n2, n3 + 1);
            d.e(n2 - 1, n3);
            d.e(n2, n3 - 1);
        }
    }

    private static void a(int n2, int n3, int n4, int n5, int n6, int n7) {
        if (n4 < 0 || n4 >= a) {
            return;
        }
        if (n5 < 0 || n5 >= a) {
            return;
        }
        if (n2 < 0 || n2 >= b) {
            return;
        }
        if (n3 < 0 || n3 >= c) {
            return;
        }
        if (!(b[n5 * a + n4] || (i[d.a((byte)n2, (byte)n3)] & 0x20) == 0 && (i[d.a((byte)n2, (byte)n3)] & 1) == 0)) {
            d.b[n5 * d.a + n4] = true;
            for (int j = 0; j < v; ++j) {
                if (n7 == j || B[j] == 2 || s[j] != n2 || t[j] != n3) continue;
                if (n6 == 2) {
                    if (C[j] == 2) continue;
                    d.i[j] = 0;
                    d.C[j] = 2;
                    d.F[j] = 3;
                    continue;
                }
                if (C[j] != 0) continue;
                d.i[j] = 0;
                d.C[j] = 1;
                d.E[j] = 1;
            }
            d.a(n2 + 1, n3, n4 + 1, n5, n6, n7);
            d.a(n2, n3 + 1, n4, n5 + 1, n6, n7);
            d.a(n2 - 1, n3, n4 - 1, n5, n6, n7);
            d.a(n2, n3 - 1, n4, n5 - 1, n6, n7);
        }
    }

    private static void b(int n2, int n3, int n4) {
        int n5;
        boolean bl = false;
        boolean bl2 = false;
        int n6 = n3 & 0xFF;
        n3 &= 0xFF;
        int n7 = g[n2];
        int n8 = h[n2];
        int n9 = g[n2];
        int n10 = h[n2];
        d.e[n2] = true;
        boolean bl3 = false;
        int n11 = n2;
        k[n11] = k[n11] + n4;
        if (k[n2] > 7000 / n6) {
            d.k[n2] = 0;
            int n12 = n2;
            K[n12] = (byte)(K[n12] + 1);
            if (K[n2] >= 4) {
                d.K[n2] = 0;
            }
        }
        if ((n5 = (n4 << 4) * n3) >= 589824) {
            n5 = 589824;
        }
        if (H[n2] == 6) {
            n9 -= n5;
        } else if (H[n2] == 2) {
            n9 += n5;
        } else if (H[n2] == 0) {
            n10 -= n5;
        } else if (H[n2] == 4) {
            n10 += n5;
        } else if (H[n2] == 1) {
            n9 += n5 * 1000 / 1414;
            n10 -= n5 * 1000 / 1414;
        } else if (H[n2] == 7) {
            n9 -= n5 * 1000 / 1414;
            n10 -= n5 * 1000 / 1414;
        } else if (H[n2] == 3) {
            n9 += n5 * 1000 / 1414;
            n10 += n5 * 1000 / 1414;
        } else {
            n9 -= n5 * 1000 / 1414;
            n10 += n5 * 1000 / 1414;
        }
        byte by = (byte)(n9 / 10 >> 16);
        byte by2 = (byte)(n10 / 10 >> 16);
        byte by3 = (byte)(n7 / 10 >> 16);
        byte by4 = (byte)(n8 / 10 >> 16);
        if (s[n2] != by || t[n2] != by2) {
            if (d.a(by3, by4) == j || d.a(by3, by4) == k) {
                bl = true;
            }
            w = true;
            if ((i[d.a(by, by2)] & 0x10) != 0 && d[n2] == -1) {
                d.a((int)by, (int)by2, n2);
            } else if (d[n2] > -1 && (i[d.a(by, by2)] & 0x10) == 0) {
                d.b(d[n2], n2);
            }
            if (d.a(by, by2) == j || d.a(by, by2) == k) {
                bl2 = true;
            }
        }
        d.a(by, by2, n9, n10, false, n2);
        n9 = c[0];
        n10 = c[1];
        d.g[n2] = n9;
        d.h[n2] = n10;
        d.e[n2] = g[n2] >> 16;
        d.f[n2] = h[n2] >> 16;
        d.s[n2] = by;
        d.t[n2] = by2;
        if (bl2) {
            d.f[n2] = true;
            return;
        }
        if (bl) {
            d.f[n2] = false;
        }
    }

    private static byte a(byte by, byte by2, byte by3, byte by4) {
        if (by3 > by) {
            if (by4 > by2) {
                return 3;
            }
            if (by4 < by2) {
                return 1;
            }
            return 2;
        }
        if (by3 < by) {
            if (by4 > by2) {
                return 5;
            }
            if (by4 < by2) {
                return 7;
            }
            return 6;
        }
        if (by4 < by2) {
            return 0;
        }
        return 4;
    }

    private static void k(int n2) {
        if (w) {
            w = false;
            t = false;
            for (int j = 0; j < v; ++j) {
                if (B[j] == 1 || B[j] == 3) {
                    d.R[j] = -1;
                    continue;
                }
                d.I[j] = 0;
                int n3 = r ? -1 : (int)d.b(s[j], t[j], g, h);
                if (n3 <= 4 && n3 != -1) {
                    byte by;
                    int n4;
                    int n5;
                    int n6;
                    int n7;
                    byte[] byArray;
                    d.R[j] = n3;
                    if (H[j] == 4 || H[j] == 0 || H[j] == 6 || H[j] == 2) {
                        byArray = b;
                        n7 = 4;
                        n6 = 3;
                    } else {
                        byArray = c;
                        n7 = 6;
                        n6 = 2;
                    }
                    if (H[j] == 4) {
                        n5 = g - s[j];
                        n4 = h - t[j];
                    } else if (H[j] == 0) {
                        n5 = s[j] - g;
                        n4 = t[j] - h;
                    } else if (H[j] == 2) {
                        n5 = h - t[j];
                        n4 = g - s[j];
                    } else if (H[j] == 6) {
                        n5 = t[j] - h;
                        n4 = s[j] - g;
                    } else if (H[j] == 5) {
                        n5 = g - s[j];
                        n4 = h - t[j];
                    } else if (H[j] == 1) {
                        n5 = s[j] - g;
                        n4 = t[j] - h;
                    } else if (H[j] == 3) {
                        n5 = s[j] - g;
                        n4 = h - t[j];
                    } else {
                        n5 = g - s[j];
                        n4 = t[j] - h;
                    }
                    int n8 = n7 + n5;
                    int n9 = n6 + n4;
                    if (n8 < 0 || n8 >= 9 || n9 < 0 || n9 >= 9 || (by = byArray[n9 * 9 + n8]) < 1 || B[j] == 2) continue;
                    d.I[j] = by;
                    if (I[j] == 1 || I[j] == 5) {
                        if (C[j] != 2) {
                            d.i[j] = 0;
                            d.C[j] = 2;
                            d.F[j] = 5;
                        }
                        w = g;
                        x = h;
                        t = true;
                        s = false;
                        continue;
                    }
                    if (I[j] == 2 && d.j) {
                        U = 300;
                        if (C[j] == 0) {
                            d.i[j] = 0;
                            d.C[j] = 1;
                            d.E[j] = 5;
                        } else if (C[j] == 1) {
                            t = true;
                            s = false;
                        }
                        w = g;
                        x = h;
                        continue;
                    }
                    if (I[j] == 3) {
                        if ((!l || s) && l) continue;
                        if (d.j) {
                            U = 300;
                        }
                        if (C[j] != 2) {
                            d.i[j] = 0;
                            d.C[j] = 2;
                            d.F[j] = 5;
                        }
                        w = g;
                        x = h;
                        t = true;
                        s = false;
                        continue;
                    }
                    if (I[j] != 4) continue;
                    if (l && !s) {
                        U = 300;
                        if (C[j] == 0) {
                            d.i[j] = 0;
                            d.C[j] = 1;
                            d.E[j] = 5;
                        } else if (C[j] == 1) {
                            t = true;
                            s = false;
                        }
                        w = g;
                        x = h;
                        continue;
                    }
                    if (l) continue;
                    if (C[j] != 2) {
                        d.i[j] = 0;
                        d.C[j] = 2;
                        d.F[j] = 5;
                    }
                    w = g;
                    x = h;
                    t = true;
                    s = false;
                    continue;
                }
                d.R[j] = -1;
            }
            return;
        }
        if (U > 0) {
            U -= n2;
            return;
        }
        for (int j = 0; j < v; ++j) {
            if (B[j] != 0) continue;
            if (I[j] == 2 && d.j) {
                U = 300;
                if (C[j] == 0) {
                    d.i[j] = 0;
                    d.C[j] = 1;
                    d.E[j] = 5;
                } else if (C[j] == 1) {
                    t = true;
                    s = false;
                }
                w = g;
                x = h;
                continue;
            }
            if (I[j] == 3) {
                if (!l || s) continue;
                U = 300;
                if (C[j] != 2) {
                    d.i[j] = 0;
                    d.C[j] = 2;
                    d.F[j] = 5;
                }
                w = g;
                x = h;
                t = true;
                s = false;
                continue;
            }
            if (I[j] != 4 || !l || s) continue;
            U = 300;
            if (C[j] == 0) {
                d.i[j] = 0;
                d.C[j] = 1;
                d.E[j] = 5;
            } else if (C[j] == 1) {
                t = true;
                s = false;
            }
            w = g;
            x = h;
        }
    }

    private static byte b(byte by, byte by2, byte by3, byte by4) {
        int n2;
        int n3;
        byte by5 = (byte)Math.abs(by - by3);
        byte by6 = (byte)Math.abs(by2 - by4);
        if (by5 > 4 || by6 > 4) {
            return -1;
        }
        int n4 = by4 - by2;
        int n5 = by3 - by;
        if (n4 < 0) {
            n4 = -n4;
            n3 = -1;
        } else {
            n3 = 1;
        }
        if (n5 < 0) {
            n5 = -n5;
            n2 = -1;
        } else {
            n2 = 1;
        }
        if ((n5 <<= 1) > (n4 <<= 1)) {
            int n6 = n4 - (n5 >> 1);
            while (by != by3) {
                byte by7 = by2;
                byte by8 = by;
                if (n6 >= 0) {
                    by2 = (byte)(by2 + n3);
                    n6 -= n5;
                }
                by = (byte)(by + n2);
                n6 += n4;
                if ((i[d.a(by, by2)] & 0x20) == 0) {
                    return -1;
                }
                if (by2 == by7 || by == by8) continue;
                if ((i[d.a(by, by7)] & 0x20) == 0) {
                    return -1;
                }
                if ((i[d.a(by8, by2)] & 0x20) != 0) continue;
                return -1;
            }
            return (byte)(by5 + by6 * 40 / 100);
        }
        int n7 = n5 - (n4 >> 1);
        while (by2 != by4) {
            byte by9 = by2;
            byte by10 = by;
            if (n7 >= 0) {
                by = (byte)(by + n2);
                n7 -= n4;
            }
            by2 = (byte)(by2 + n3);
            n7 += n5;
            if ((i[d.a(by, by2)] & 0x20) == 0) {
                return -1;
            }
            if (by2 == by9 || by == by10) continue;
            if ((i[d.a(by, by9)] & 0x20) == 0) {
                return -1;
            }
            if ((i[d.a(by10, by2)] & 0x20) != 0) continue;
            return -1;
        }
        return (byte)(by6 + by5 * 40 / 100);
    }

    public static final boolean a() {
        d.l[2] = l[0];
        d.l[3] = l[1];
        d.l[0] = J <= v >> 1 ? v >> 1 : (J >= b * 10 - (v >> 1) ? b * 10 - (v >> 1) : J);
        d.l[1] = K <= w >> 1 ? w >> 1 : (K >= c * 10 - (w >> 1) ? c * 10 - (w >> 1) : K);
        return l[0] != l[2] || l[1] != l[3];
    }

    public final void b(int n2) {
        if (J < S.length && n2 == S[J]) {
            if ((J = (byte)(J + 1)) == S.length) {
                J = 0;
                this.i();
                return;
            }
        } else if (J < S.length && n2 == S[4 - J]) {
            J = (byte)(J + 1);
        } else {
            if (J == S.length) {
                J = 0;
                switch (n2) {
                    case 10: {
                        this.l(-1);
                        return;
                    }
                    case 11: {
                        this.l(0);
                        return;
                    }
                    case 12: {
                        this.l(1);
                        return;
                    }
                    case 13: {
                        this.l(2);
                        return;
                    }
                    case 14: {
                        this.l(3);
                        return;
                    }
                    case 15: {
                        this.l(4);
                        return;
                    }
                    case 16: {
                        this.l(5);
                        return;
                    }
                    case 17: {
                        this.l(6);
                        return;
                    }
                    case 18: {
                        this.l(7);
                        return;
                    }
                    case 19: {
                        this.l(8);
                    }
                }
                return;
            }
            J = 0;
        }
        if (d == 1) {
            switch (n2) {
                case 5: {
                    z = 0;
                    d.d();
                    h.a(13, this);
                    break;
                }
                case 6: {
                    break;
                }
                case 1: 
                case 12: {
                    z |= 1;
                    break;
                }
                case 2: 
                case 18: {
                    z |= 2;
                    break;
                }
                case 3: 
                case 14: {
                    z |= 4;
                    break;
                }
                case 4: 
                case 16: {
                    z |= 8;
                    break;
                }
                case 11: {
                    z |= 5;
                    break;
                }
                case 13: {
                    z |= 9;
                    break;
                }
                case 17: {
                    z |= 6;
                    break;
                }
                case 19: {
                    z |= 0xA;
                    break;
                }
                case 7: 
                case 15: {
                    u = true;
                    break;
                }
                case 20: 
                case 21: {
                    n = true;
                }
            }
            return;
        }
        if (d == 0) {
            switch (n2) {
                case 6: {
                    z = 0;
                    d.d();
                    h.a(13, this);
                    return;
                }
                case 5: {
                    i.a(k.a[A], -1);
                    f = 0;
                    z = 0;
                    k = l = (byte)(a[1] * 4 + 20);
                    c = (byte)(a[2] * 6 + 80);
                    d = 1;
                    k.b();
                    e = true;
                    K = a[3];
                    return;
                }
                case 1: 
                case 12: {
                    z |= 1;
                    e = (byte)(e - 1);
                    if (e >= 0) break;
                    e = (byte)3;
                    return;
                }
                case 2: 
                case 18: {
                    z |= 2;
                    e = (byte)(e + 1);
                    if (e <= 3) break;
                    e = 0;
                    return;
                }
                case 3: 
                case 14: {
                    z |= 4;
                    if (a[e] <= k.a[e]) break;
                    byte by = e;
                    a[by] = (byte)(a[by] - 1);
                    b = (short)(b + a[e]);
                    return;
                }
                case 4: 
                case 16: {
                    z |= 8;
                    if (a[e] >= 5 || b < a[e]) break;
                    byte by = e;
                    a[by] = (byte)(a[by] + 1);
                    b = (short)(b - a[e]);
                    return;
                }
                case 7: 
                case 15: {
                    switch (e) {
                        case 0: {
                            E = 48;
                            return;
                        }
                        case 1: {
                            E = 49;
                            return;
                        }
                        case 2: {
                            E = 50;
                            return;
                        }
                        case 3: {
                            E = 51;
                        }
                    }
                }
            }
        }
    }

    private void i() {
        if (d == 1) {
            if (k < l && d != 0) {
                k = l;
                c = true;
                return;
            }
            i = true;
            return;
        }
        if (d == 0) {
            b = (short)20000;
        }
    }

    private void l(int n2) {
        if (d == 1) {
            i = true;
            k.a = (byte)n2;
        }
    }

    public final void e(int n2) {
        switch (n2) {
            case 1: 
            case 12: {
                z &= 0xFFFFFFFE;
                return;
            }
            case 2: 
            case 18: {
                z &= 0xFFFFFFFD;
                return;
            }
            case 3: 
            case 14: {
                z &= 0xFFFFFFFB;
                return;
            }
            case 4: 
            case 16: {
                z &= 0xFFFFFFF7;
                return;
            }
            case 11: {
                z &= 0xFFFFFFFA;
                return;
            }
            case 13: {
                z &= 0xFFFFFFF6;
                return;
            }
            case 17: {
                z &= 0xFFFFFFF9;
                return;
            }
            case 19: {
                z &= 0xFFFFFFF5;
            }
        }
    }

    private void m(int n2) {
        int n3 = 9999;
        m = false;
        P = -1;
        if ((O -= n2) <= 0) {
            O = 0;
        }
        if (o == 0 && !p && T == 0) {
            int n4;
            for (n4 = 0; n4 < R.length; ++n4) {
                int n5;
                if (R[n4] == -1 || B[n4] == 1 || B[n4] == 3 || (n5 = (R[n4] << 2) + x[n4]) >= n3) continue;
                n3 = n5;
                P = n4;
            }
            if (P == -1) {
                return;
            }
            if (k) {
                byte by = this.c(g, h, s[P], t[P]);
                n4 = by;
                if (by != -1) {
                    i = (byte)n4;
                }
            }
            if (k && O == 0) {
                m = true;
                O = 500;
                s = false;
                t = 1;
                u = 0;
                j = i;
                n4 = C[P] != 2 ? d.b((int)R[P], (int)a[0]) : d.a((int)R[P], (int)a[0]);
                if (n4 > 0) {
                    if (C[P] != 2) {
                        n4 *= 3;
                        C = 1;
                        D = P;
                        D = (byte)(D + 1);
                    }
                    if (B[P] == 2) {
                        d.B[d.P] = 0;
                    }
                    int n6 = P;
                    x[n6] = (byte)(x[n6] - n4);
                    if (x[P] <= 0) {
                        d.n(P);
                    }
                }
                if (C[P] != 2) {
                    d.i[d.P] = 0;
                    d.C[d.P] = 2;
                    d.F[d.P] = 5;
                    w = g;
                    x = h;
                    t = true;
                    s = false;
                }
            }
        }
    }

    private static int a(int n2, int n3) {
        int n4 = d.d(n3);
        if (Math.abs(k.a() % 101) <= f[n2] + n3 * n2) {
            int n5 = e[n2] + k.a() % 2 + n4;
            if (n5 < 1) {
                n5 = 1;
            }
            return n5;
        }
        return 0;
    }

    private static int b(int n2, int n3) {
        int n4 = d.d(n3);
        int n5 = e[n2] + k.a() % 2 + n4;
        if (n5 < 1) {
            n5 = 1;
        }
        return n5;
    }

    private static int d(int n2) {
        int n3 = 0;
        switch (n2) {
            case 0: {
                break;
            }
            case 1: 
            case 2: {
                n3 = 1;
                break;
            }
            case 3: 
            case 4: {
                n3 = 2;
                break;
            }
            case 5: {
                n3 = 3;
            }
        }
        return n3;
    }

    private static void n(int n2) {
        d.B[n2] = 3;
        d.G[n2] = 0;
        d.i[n2] = 0;
        C = (byte)(C + 1);
    }

    private static void o(int n2) {
        d.B[n2] = 1;
        if (g[y[n2]]) {
            d = true;
        }
        d.h(n2);
        if (d[n2] > -1) {
            d.b(d[n2], n2);
        }
    }

    private byte c(byte by, byte by2, byte by3, byte by4) {
        if (by == by3 && by2 == by4) {
            return -1;
        }
        int n2 = 4 + by3 - by;
        int n3 = 4 + by4 - by2;
        return d[n3 * 9 + n2];
    }

    private void p(int n2) {
        for (int j = 0; j < v; ++j) {
            d.d[j] = false;
            int n3 = j;
            d.j[n3] = d.j[n3] - n2;
            if (d.j[j] <= 0) {
                d.j[j] = 0;
            }
            if (C[j] == 2 && R[j] != -1 && F[j] != 3 && F[j] != 5 && B[j] == 0 && !s) {
                byte by = this.c(s[j], t[j], g, h);
                if (by != -1) {
                    d.H[j] = by;
                }
                w = g;
                x = h;
                t = true;
                s = false;
                d.c[j] = true;
                if (d.j[j] != 0) continue;
                if (o == 0) {
                    k = true;
                    c = true;
                }
                d.d[j] = true;
                d.j[j] = 500;
                d.L[j] = 1;
                d.M[j] = 0;
                int n4 = d.a((int)R[j], (int)O[y[j]]);
                if (n4 <= 0) continue;
                c = true;
                if ((k = (byte)(k - n4)) > 0) continue;
                d.g();
                continue;
            }
            d.c[j] = false;
        }
    }

    public final void c(int n2) {
        if (g) {
            return;
        }
        if (n2 < 1) {
            n2 = 1;
        }
        if (d == 1 && B) {
            if (y) {
                this.l();
                B = false;
                return;
            }
            if (h) {
                this.m();
                B = false;
                return;
            }
            d.g(n2);
            d.j(n2);
            d.k(n2);
            this.m(n2);
            if (j != i) {
                t = 0;
            }
            this.p(n2);
            d.j();
            if (!h && T == 0) {
                d.k();
            }
            if (i && h.a() instanceof d && H == 0 && x && T == 0) {
                y = true;
                i = false;
                return;
            }
        } else if (d == 0) {
            if ((V += n2) > 200) {
                z = !z;
                V = 0;
            }
            if (A == 1 && !A) {
                A = true;
                k.a(52, null);
                return;
            }
            if (E != -1) {
                k.a(E, null);
                E = -1;
            }
        }
    }

    private static void j() {
        if (!t && !j && l && !m) {
            s = true;
            return;
        }
        s = false;
    }

    private static void k() {
        if (H > 0) {
            if (A == 5 && H == 1 && G == 1) {
                G = (byte)2;
            }
            --H;
            --I;
            k.a(d[0], null);
            for (int j = 0; j < d.length - 1; ++j) {
                d.d[j] = d[j + 1];
            }
            return;
        }
        if (i && !x) {
            i.a(-1, 1);
            x = true;
            boolean bl = false;
            int n2 = C * 50;
            int n3 = D * 20;
            int n4 = 0;
            switch (E) {
                case 4: {
                    n4 = 80;
                    break;
                }
                case 3: {
                    n4 = 160;
                    break;
                }
                case 2: {
                    n4 = 320;
                    break;
                }
                case 1: {
                    n4 = 480;
                    break;
                }
                case 0: {
                    n4 = 640;
                }
            }
            b = (short)(b + (1000 + n2 + n4 + n3));
            k.a(1000, n2, n4, n3, C, D);
            return;
        }
        if (A == 4 && H != -1) {
            d.a(H, I, (int)e);
            a.a(H * 10, I * 10, H * 10 + 10, I * 10 + 10, l[0], l[1]);
        }
    }

    public final void a(Graphics graphics) {
        if (g) {
            return;
        }
        if ((A == 0 || A == 9) && d || A == 5 && G == 2) {
            graphics.setColor(3158580);
            graphics.setClip(0, 0, n.b, n.c);
            graphics.fillRect(0, 0, n.b, n.c);
            return;
        }
        if (e && (h.a() instanceof d || h.a() instanceof l)) {
            e = false;
            if (d == 0) {
                graphics.setColor(3158580);
            } else {
                graphics.setColor(0);
            }
            graphics.setClip(0, 0, n.b, n.c);
            graphics.fillRect(0, 0, n.b, n.c);
            c = true;
        }
        if (d == 1) {
            graphics.setClip(t, u, v, w);
            a.a(graphics, l[0], l[1], t, u);
            d.c(graphics);
            d.g(graphics);
            d.f(graphics);
            d.b(graphics);
            graphics.setClip(t, u, v, w + 20);
            d.e(graphics);
        } else if (d == 0) {
            boolean bl = false;
            boolean bl2 = false;
            graphics.setClip(0, 0, n.b, n.c);
            graphics.setColor(3158580);
            graphics.fillRect(0, 0, n.b, n.c);
            graphics.setFont(a);
            graphics.setColor(0xFFFFFF);
            graphics.drawString((String)b.a(53), 6, 1, 20);
            graphics.drawString("" + b, n.b - 6, 1, 24);
            graphics.drawString((String)b.a(54), 6, graphics.getFont().getHeight() + 1, 20);
            graphics.drawString("" + a[e], n.b - 6, graphics.getFont().getHeight() + 1, 24);
            int n2 = graphics.getFont().getHeight() << 1;
            int n3 = n.c - n2;
            int n4 = b.a(179, 3);
            int n5 = b.a(179, 2);
            n3 -= n4 << 2;
            graphics.setColor(16745728);
            graphics.fillRect(6, (n2 += (n3 /= 5)) + e * (n3 + n4), 23, 15);
            if (e != 0) {
                graphics.setColor(0x445566);
                graphics.fillRect(6, n2, 23, 15);
            }
            b.a(6, n2, 179, graphics);
            d.a(n2, n5 + 10 + 6, (int)a[0], (int)k.a[0], a[0], graphics);
            n2 += n3 + n4;
            if (e != 1) {
                graphics.setColor(0x445566);
                graphics.fillRect(6, n2, 23, 15);
            }
            b.a(6, n2, 166, graphics);
            d.a(n2, n5 + 10 + 6, (int)a[1], (int)k.a[1], a[1], graphics);
            n2 += n3 + n4;
            if (e != 2) {
                graphics.setColor(0x445566);
                graphics.fillRect(6, n2, 23, 15);
            }
            b.a(6, n2, 165, graphics);
            d.a(n2, n5 + 10 + 6, (int)a[2], (int)k.a[2], a[2], graphics);
            n2 += n3 + n4;
            if (e != 3) {
                graphics.setColor(0x445566);
                graphics.fillRect(6, n2, 23, 15);
            }
            b.a(6, n2, 178, graphics);
            d.a(n2, n5 + 10 + 6, (int)a[3], (int)k.a[3], a[3], graphics);
            graphics.setClip(0, 0, n.b, n.c);
        }
        graphics.setClip(0, 0, n.b, n.c);
        if (h.a() instanceof d) {
            this.d(graphics);
        }
    }

    private static void b(Graphics graphics) {
        int n2;
        int n3;
        int n4;
        if (P > -1 && o == 0) {
            n4 = e[P] - l[0] + (v >> 1) + t;
            n3 = f[P] - l[1] + (w >> 1) + u;
            graphics.setColor(0x111111);
            n2 = N[y[P]] * 65 / 100;
            graphics.drawRect(n4 - (n2 >> 1), n3 - 18, n2, 4);
            graphics.setColor(0xDD0000);
            graphics.fillRect(n4 - (n2 >> 1) + 1, n3 - 17, (x[P] << 16) / N[y[P]] * (n2 - 1) >> 16, 3);
        }
        if (C > 0) {
            n4 = e[D] - l[0] + (v >> 1) + t;
            n3 = f[D] - l[1] + (w >> 1) + u;
            n2 = ((C << 16) / 1300 << 2 >> 16) + 6;
            b.a(n4, n3 - n2, 294, graphics);
        }
        if (q && T < 1) {
            n4 = J - l[0] + (v >> 1) + t;
            n3 = K - l[1] + (w >> 1) + u;
            graphics.setColor(0x111111);
            n2 = l * 65 / 100;
            graphics.drawRect(n4 - (n2 >> 1), n3 - 18, n2, 4);
            graphics.setColor(0xDD0000);
            graphics.fillRect(n4 - (n2 >> 1) + 1, n3 - 17, (k << 16) / l * (n2 - 1) >> 16, 3);
        }
        for (n2 = 0; n2 < v; ++n2) {
            n4 = e[n2] - l[0] + (v >> 1) + t;
            n3 = f[n2] - l[1] + (w >> 1) + u;
            if (B[n2] == 1 || !d.a(n4, n3) || d.a(s[n2], t[n2], f[n2])) continue;
            if (C[n2] == 2 && (F[n2] == 3 || F[n2] == 5)) {
                b.a(n4, n3, 181, graphics);
                continue;
            }
            if (C[n2] != 1 || E[n2] != 1 && E[n2] != 5) continue;
            b.a(n4, n3, 180, graphics);
        }
    }

    private static void a(int n2, int n3, int n4, int n5, int n6, Graphics graphics) {
        int n7 = 0;
        int n8 = 0;
        for (int j = 0; j < 7; ++j) {
            int n9;
            n8 = 0;
            if (j == 0) {
                if (n4 > n5) {
                    n9 = 169;
                    n8 = 1;
                } else {
                    n9 = -1;
                }
            } else if (j == 6) {
                if (n4 < 5 && n6 <= b) {
                    n9 = 170;
                    n8 = 1;
                } else {
                    n9 = -1;
                }
            } else {
                n9 = j - 1 >= n4 ? 167 : (j - 1 >= n5 ? (z ? 168 : 167) : 168);
            }
            if (n9 != -1) {
                b.a(n3 + n7, n2 + n8 + (b.a(179, 3) >> 1) - (b.a(167, 3) >> 1), n9, graphics);
                n7 += b.a(n9, 2) + 2;
                continue;
            }
            n7 += b.a(169, 2) + 2;
        }
    }

    private static void c(Graphics graphics) {
        int n2 = Q - l[0] + (v >> 1) + t;
        int n3 = R - l[1] + (w >> 1) + u;
        if ((S > 0 || o) && d.a(q, r, false)) {
            return;
        }
        if (S > 0) {
            b.a(n2, n3, 171 + s, graphics);
            return;
        }
        if (o && d.a(n2, n3)) {
            b.a(n2, n3, 176, graphics);
            d.a(q, r, n2, graphics);
        }
    }

    private void d(Graphics graphics) {
        if (h.a() == this && d == 1) {
            b.a(2, n.c - 2 - b.a(298, 3), 298, graphics);
        }
    }

    private static void e(Graphics graphics) {
        if (!c) {
            return;
        }
        graphics.setColor(3158580);
        graphics.fillRect(t, w + u, v, 20);
        graphics.setColor(0x445566);
        int n2 = v - b.a(179, 2) - 5;
        int n3 = w + 3;
        boolean bl = false;
        int n4 = w + 10 - (b.a(293, 3) >> 1);
        int n5 = (l << 16) / 40 * 50 >> 16;
        int n6 = (k << 16) / 40 * 50 >> 16;
        if (n6 < 0) {
            n6 = 0;
        }
        graphics.fillRect(n2 + t, n3 + u, 23, 15);
        if (o == 0) {
            if (k) {
                graphics.setColor(16745728);
                graphics.fillRect(n2 + t, n3 + u, 23, 15);
            }
            b.a(n2 + t, n3 + u, 179, graphics);
        } else if (o == 1) {
            if (o) {
                graphics.setColor(16745728);
                graphics.fillRect(n2 + t, n3 + u, 23, 15);
            }
        } else if (o == 2 && f > 0) {
            graphics.setColor(16745728);
            graphics.fillRect(n2 + t, n3 + u, 23, 15);
        }
        if (o == 1) {
            b.a(n2 + t, n3 + u, 178, graphics);
            b.a(n2 - b.a(13, 2) + t, n3 + u, 13 + a[3], graphics);
        }
        if (o == 2) {
            b.a(n2 + t, n3 + u, 177, graphics);
            b.a(n2 - b.a(13, 2) + t, n3 + u, 13 + m, graphics);
        }
        d.a(3 + n5, n4, 50 - n5, 293, graphics);
        d.a(3 + n6, n4, n5 - n6, 292, graphics);
        d.a(3, n4, n6, 291, graphics);
        c = false;
    }

    private static void a(int n2, int n3, int n4, int n5, Graphics graphics) {
        if (n4 <= 0) {
            return;
        }
        int n6 = b.a(n5, 2);
        int n7 = n4 / n6;
        if (n7 == 0) {
            graphics.setClip(n2 + t, u, n4, w + 20);
            b.a(n2 + t, n3 + u, n5, graphics);
            graphics.setClip(t, u, v, w + 20);
            return;
        }
        int n8 = n4 % n6;
        int n9 = n2;
        for (int j = 0; j < n7; ++j) {
            n9 = n2 + j * n6;
            b.a(n9 + t, n3 + u, n5, graphics);
        }
        b.a(n9 + n8 + t, n3 + u, n5, graphics);
    }

    private static boolean a(byte by, byte by2, boolean bl) {
        if (!b && (i[d.a(by, by2)] & 2) != 0 && !bl) {
            return true;
        }
        if (!a[by2 * b + by] && (i[d.a(by, by2)] & 2) != 0 && !bl) {
            return true;
        }
        if (b && !a && !a[by2 * b + by]) {
            return true;
        }
        return b && !a && a[by2 * b + by] && d.a(by, by2) >= B && (i[d.b(by, by2)] & 2) == 0;
    }

    private static void f(Graphics graphics) {
        for (int j = 0; j < v; ++j) {
            int n2;
            int n3;
            int n4 = e[j] - l[0] + (v >> 1) + t;
            int n5 = f[j] - l[1] + (w >> 1) + u;
            if (B[j] == 1 || !d.a(n4, n5) || d.a(s[j], t[j], f[j])) continue;
            int n6 = -1;
            if (H[j] == 2) {
                n3 = e[y[j]];
                n2 = 234;
                if (L[j] > 0) {
                    n6 = d.a(2, M[j]);
                }
                if (e[j]) {
                    n2 = 234 + K[j];
                }
            } else if (H[j] == 3) {
                n3 = e[y[j]] + 1;
                n2 = 250;
                if (L[j] > 0) {
                    n6 = d.a(3, M[j]);
                }
                if (e[j]) {
                    n2 = 250 + K[j];
                }
            } else if (H[j] == 4) {
                n3 = e[y[j]] + 2;
                n2 = 246;
                if (L[j] > 0) {
                    n6 = d.a(4, M[j]);
                }
                if (e[j]) {
                    n2 = 246 + K[j];
                }
            } else if (H[j] == 5) {
                n3 = e[y[j]] + 3;
                n2 = 254;
                if (L[j] > 0) {
                    n6 = d.a(5, M[j]);
                }
                if (e[j]) {
                    n2 = 254 + K[j];
                }
            } else if (H[j] == 6) {
                n3 = e[y[j]] + 4;
                n2 = 238;
                if (L[j] > 0) {
                    n6 = d.a(6, M[j]);
                }
                if (e[j]) {
                    n2 = 238 + K[j];
                }
            } else if (H[j] == 7) {
                n3 = e[y[j]] + 5;
                n2 = 258;
                if (L[j] > 0) {
                    n6 = d.a(7, M[j]);
                }
                if (e[j]) {
                    n2 = 258 + K[j];
                }
            } else if (H[j] == 0) {
                n3 = e[y[j]] + 6;
                n2 = 242;
                if (L[j] > 0) {
                    n6 = d.a(0, M[j]);
                }
                if (e[j]) {
                    n2 = 242 + K[j];
                }
            } else {
                n3 = e[y[j]] + 7;
                n2 = 262;
                if (L[j] > 0) {
                    n6 = d.a(1, M[j]);
                }
                if (e[j]) {
                    n2 = 262 + K[j];
                }
            }
            b.a(n4, n5, n2, graphics);
            b.a(n4, n5, n3, graphics);
            if (o == 0 && R[j] != -1) {
                if (P == j) {
                    int n7 = 0;
                    switch (R[j]) {
                        case 4: {
                            break;
                        }
                        case 3: {
                            n7 = 1;
                            break;
                        }
                        case 2: {
                            n7 = 2;
                            break;
                        }
                        case 0: 
                        case 1: {
                            n7 = 3;
                        }
                    }
                    int n8 = n7 + d.d(a[0]) - 4;
                    b.a(n4 + n8, n5 + n8, 218, graphics);
                    b.a(n4 - n8, n5 + n8, 219, graphics);
                    b.a(n4 + n8, n5 - n8, 221, graphics);
                    b.a(n4 - n8, n5 - n8, 220, graphics);
                } else if (B[j] != 3) {
                    b.a(n4, n5, 214, graphics);
                    b.a(n4, n5, 215, graphics);
                    b.a(n4, n5, 217, graphics);
                    b.a(n4, n5, 216, graphics);
                }
            }
            if (L[j] > 0) {
                b.a(n4, n5, n6, graphics);
            }
            if (f[j] && !b) continue;
            d.a(s[j], t[j], n4, graphics);
        }
    }

    private static boolean a(int n2, int n3) {
        return n2 <= v + 10 + t && n2 >= -10 + t && n3 <= w + 10 + u && n3 >= -10 + u;
    }

    private static void g(Graphics graphics) {
        int n2 = J - l[0] + (v >> 1) + t;
        int n3 = K - l[1] + (w >> 1) + u;
        if (!p) {
            int n4;
            int n5;
            int n6;
            int n7 = -1;
            if (i == 0) {
                n6 = k ? 232 : 188;
                n5 = 273;
                if (t > 0) {
                    n7 = d.a(0, u);
                }
                n4 = 242;
                if (j) {
                    n4 = 242 + p;
                }
            } else if (i == 4) {
                n6 = k ? 228 : 184;
                n5 = 269;
                if (t > 0) {
                    n7 = d.a(4, u);
                }
                n4 = 246;
                if (j) {
                    n4 = 246 + p;
                }
            } else if (i == 6) {
                n6 = k ? 230 : 186;
                n5 = 271;
                if (t > 0) {
                    n7 = d.a(6, u);
                }
                n4 = 238;
                if (j) {
                    n4 = 238 + p;
                }
            } else if (i == 2) {
                n6 = k ? 226 : 182;
                n5 = 267;
                if (t > 0) {
                    n7 = d.a(2, u);
                }
                n4 = 234;
                if (j) {
                    n4 = 234 + p;
                }
            } else if (i == 1) {
                n6 = k ? 233 : 189;
                n5 = 274;
                if (t > 0) {
                    n7 = d.a(1, u);
                }
                n4 = 262;
                if (j) {
                    n4 = 262 + p;
                }
            } else if (i == 7) {
                n6 = k ? 231 : 187;
                n5 = 272;
                if (t > 0) {
                    n7 = d.a(7, u);
                }
                n4 = 258;
                if (j) {
                    n4 = 258 + p;
                }
            } else if (i == 3) {
                n6 = k ? 227 : 183;
                n5 = 268;
                if (t > 0) {
                    n7 = d.a(3, u);
                }
                n4 = 250;
                if (j) {
                    n4 = 250 + p;
                }
            } else {
                n6 = k ? 229 : 185;
                n5 = 270;
                if (t > 0) {
                    n7 = d.a(5, u);
                }
                n4 = 254;
                if (j) {
                    n4 = 254 + p;
                }
            }
            b.a(n2, n3, n4, graphics);
            b.a(n2, n3, n6, graphics);
            if (l) {
                b.a(n2, n3, n5, graphics);
            }
            if (t > 0) {
                b.a(n2, n3, n7, graphics);
            }
            d.a(g, h, n2, graphics);
            if (h > 0) {
                for (int j = -1; j < 2; ++j) {
                    int n8;
                    int n9;
                    if (g + j < 0 || g + j >= b || (n9 = d.a((byte)(g + j), (byte)(h - 1))) < B || (n8 = d.c(n9)) != 50 && n8 != 51 && n8 != 52 && n8 != 53) continue;
                    d.a(g, (byte)(h - 1), n2, graphics);
                    return;
                }
            }
        }
    }

    private static int a(int n2, byte by) {
        if (n2 == 0) {
            if (by % 2 == 0) {
                return 281;
            }
            return 289;
        }
        if (n2 == 4) {
            if (by % 2 == 0) {
                return 277;
            }
            return 285;
        }
        if (n2 == 6) {
            if (by % 2 == 0) {
                return 279;
            }
            return 287;
        }
        if (n2 == 2) {
            if (by % 2 == 0) {
                return 275;
            }
            return 283;
        }
        if (n2 == 1) {
            if (by % 2 == 0) {
                return 282;
            }
            return 290;
        }
        if (n2 == 7) {
            if (by % 2 == 0) {
                return 280;
            }
            return 288;
        }
        if (n2 == 5) {
            if (by % 2 == 0) {
                return 278;
            }
            return 286;
        }
        if (by % 2 == 0) {
            return 276;
        }
        return 284;
    }

    private static void a(byte by, byte by2, int n2, Graphics graphics) {
        graphics.setClip(n2 - 5, u, 10, w);
        graphics.clipRect(t, u, v, w);
        for (int j = -1; j < 2; ++j) {
            int n3;
            int n4;
            byte by3 = (byte)(by + j);
            if (by3 < 0 || by3 >= b || (i[n4 = d.a(n3 = by2 * b + by3)] & 0x80) == 0 || (i[d.a(by, by2)] & 2) != 0 && (i[n4] & 2) == 0 || (i[d.a(by, by2)] & 2) == 0 && (i[n4] & 2) != 0) continue;
            if (n4 >= B) {
                int n5 = d.c(n4);
                if (!b && (i[n5] & 2) != 0) {
                    m.a(by3 * 10 - l[0] + (v >> 1) + t, by2 * 10 - l[1] + (w >> 1) + u, n5, graphics);
                    continue;
                }
                if (b && !a[by2 * b + by3] && (i[n5] & 2) != 0) {
                    m.a(by3 * 10 - l[0] + (v >> 1) + t, by2 * 10 - l[1] + (w >> 1) + u, n5, graphics);
                    continue;
                }
                b.a(by3 * 10 - l[0] + (v >> 1) + t, by2 * 10 - l[1] + (w >> 1) + u, n5, graphics);
                continue;
            }
            if (!b && (i[n4] & 2) != 0) {
                m.a(by3 * 10 - l[0] + (v >> 1) + t, by2 * 10 - l[1] + (w >> 1) + u, n4, graphics);
            }
            if (b && !a[by2 * b + by3] && (i[n4] & 2) != 0) {
                m.a(by3 * 10 - l[0] + (v >> 1) + t, by2 * 10 - l[1] + (w >> 1) + u, n4, graphics);
                continue;
            }
            b.a(by3 * 10 - l[0] + (v >> 1) + t, by2 * 10 - l[1] + (w >> 1) + u, n4, graphics);
        }
        graphics.setClip(t, u, v, w);
    }

    public static final void a(int n2) {
        d.q(n2);
        d.a();
    }

    private static void q(int n2) {
        int n3;
        a = Font.getFont((int)64, (int)0, (int)8);
        if (!f) {
            b = k.a;
            d.a[0] = k.a[0];
            d.a[1] = k.a[1];
            d.a[2] = k.a[2];
            d.a[3] = k.a[3];
        }
        H = (byte)-1;
        G = 0;
        f = 0;
        B = true;
        J = 0;
        S = new byte[5];
        d.S[0] = 11;
        d.S[1] = 13;
        d.S[2] = 19;
        d.S[3] = 17;
        d.S[4] = 15;
        f = false;
        a = k.a;
        F = 0;
        E = -1;
        e = false;
        A = false;
        V = 0;
        C = 0;
        D = 0;
        E = 0;
        y = false;
        x = false;
        n = 0;
        r = false;
        t = 0;
        s = false;
        J = g * 10 + 5;
        K = h * 10 + 5;
        L = J << 16;
        M = K << 16;
        i = (byte)4;
        j = false;
        T = 0;
        k = false;
        a = false;
        m = 0;
        O = 0;
        C = 0;
        d = (short)-1;
        N = 0;
        p = 0;
        o = 0;
        o = false;
        p = false;
        S = 0;
        s = 0;
        e = 0;
        c = true;
        u = false;
        v = true;
        w = true;
        R = new byte[v];
        a = 11;
        e = a * a;
        b = new boolean[e];
        for (n3 = 0; n3 < v; ++n3) {
            d.R[n3] = -1;
        }
        n3 = b * c;
        a = new short[n3];
        g = new byte[n3];
        b = new short[n3];
        c = new short[n3 + 2];
        h = new byte[n3];
        c = new int[2];
        g = false;
        A = n2;
        h = false;
        i = false;
        d = false;
        H = 0;
        I = 0;
        b = (i[d.a(g, h)] & 2) != 0;
        a = new boolean[b * c];
        if (b) {
            d.d(g, h);
        }
        int n4 = d.a(g, h);
        l = false;
        for (int j = 0; j < b.length; ++j) {
            if (n4 >= B && d.b(n4) == b[j]) {
                l = true;
                break;
            }
            if (n4 != b[j]) continue;
            l = true;
            break;
        }
        z = 0;
        u = false;
        if (A != 0) {
            d = 0;
        } else {
            k = l = (byte)20;
            d.a[3] = 2;
            c = (short)80;
            d = 1;
        }
        if (A == 6) {
            o = (byte)2;
        }
    }

    public static final void b() {
        a = null;
        System.gc();
    }

    public static final void c() {
        a = new m(v, w, 10, 10, b, c);
        a.a(l[0], l[1]);
    }

    public static final void f(int n2) {
        int n3 = 0;
        F = 9999;
        G = 0;
        try {
            int n4;
            int n5;
            int n6;
            int n7;
            byte[] byArray = (byte[])((Object[])b.a(10))[0];
            ++n3;
            z = byArray[0];
            N = new byte[z];
            O = new byte[z];
            e = new short[z];
            P = new byte[z];
            Q = new byte[z];
            g = new boolean[z];
            for (n7 = 0; n7 < z; ++n7) {
                d.P[n7] = byArray[n3++];
                d.Q[n7] = byArray[n3++];
                d.O[n7] = byArray[n3++];
                d.N[n7] = byArray[n3++];
                d.g[n7] = (n6 = byArray[n3++]) != 0;
                d.e[n7] = (short)(((byArray[n3++] & 0xFF) << 8) + (byArray[n3++] & 0xFF));
            }
            int n8 = byArray[n3++] & 0xFF;
            n6 = byArray[n3++] & 0xFF;
            B = n6 + 1;
            byte[] byArray2 = new byte[n6 + 1];
            for (n7 = 0; n7 < n8; ++n7) {
                n5 = byArray[n3++] & 0xFF;
                n4 = byArray[n3++];
                byArray2[n5] = (byte)n4;
            }
            n6 = 0;
            for (n7 = 0; n7 <= n2; ++n7) {
                n3 += n6;
                n6 = ((byArray[n3++] & 0xFF) << 8) + (byArray[n3++] & 0xFF);
            }
            g = byArray[n3++];
            h = byArray[n3++];
            b = byArray[n3++];
            c = byArray[n3++];
            k = new byte[b * c];
            for (n7 = 0; n7 < b * c; ++n7) {
                d.k[n7] = byArray[n3++];
            }
            v = byArray[n3++];
            s = new byte[v];
            t = new byte[v];
            u = new byte[v];
            v = new byte[v];
            w = new byte[v];
            e = new int[v];
            f = new int[v];
            g = new int[v];
            h = new int[v];
            H = new byte[v];
            y = new byte[v];
            B = new byte[v];
            x = new byte[v];
            z = new byte[v];
            c = new boolean[v];
            A = new byte[v];
            C = new byte[v];
            D = new byte[v];
            E = new byte[v];
            F = new byte[v];
            i = new int[v];
            I = new byte[v];
            G = new byte[v];
            c = new byte[v][];
            d = new byte[v][16];
            e = new byte[v][16];
            J = new byte[v];
            k = new int[v];
            K = new byte[v];
            e = new boolean[v];
            d = new boolean[v];
            j = new int[v];
            d = new short[v];
            f = new boolean[v];
            L = new byte[v];
            M = new byte[v];
            for (n7 = 0; n7 < v; ++n7) {
                d.z[n7] = byArray[n3++];
                d.y[n7] = byArray[n3++];
                d.B[n7] = (n6 = byArray[n3++]) == 0 ? 2 : 0;
                d.c[n7] = new byte[byArray[n3++] * 4];
                for (n5 = 0; n5 < c[n7].length; n5 += 4) {
                    d.c[n7][n5] = byArray[n3++];
                    d.c[n7][n5 + 1] = byArray[n3++];
                    d.c[n7][n5 + 2] = byArray[n3++];
                    d.c[n7][n5 + 3] = byArray[n3++];
                    if (n5 != 0) continue;
                    d.H[n7] = c[n7][n5 + 3];
                }
                d.s[n7] = c[n7][0];
                d.t[n7] = c[n7][1];
                d.i[n7] = 0;
                d.A[n7] = 0;
                d.e[n7] = s[n7] * 10 + 5;
                d.f[n7] = t[n7] * 10 + 5;
                d.g[n7] = e[n7] << 16;
                d.h[n7] = f[n7] << 16;
                d.D[n7] = 0;
                d.F[n7] = 0;
                d.E[n7] = 0;
                d.x[n7] = N[y[n7]];
                d.C[n7] = 0;
                d.k[n7] = 0;
                d.K[n7] = 0;
                d.e[n7] = false;
                d.j[n7] = 0;
                d.d[n7] = -1;
                d.L[n7] = 0;
                d.f[n7] = false;
            }
            A = byArray[n3++];
            l = new byte[A];
            m = new byte[A];
            n = new byte[A];
            o = new byte[A];
            p = new byte[A];
            q = new byte[A];
            a = new byte[A][];
            for (n7 = 0; n7 < A; ++n7) {
                d.l[n7] = byArray[n3++];
                d.m[n7] = byArray[n3++];
                d.n[n7] = byArray[n3++];
                d.o[n7] = byArray[n3++];
                d.p[n7] = byArray[n3++];
                d.q[n7] = byArray[n3++];
                d.a[n7] = new byte[byArray[n3++] * 4];
                for (n5 = 0; n5 < a[n7].length; n5 += 4) {
                    d.a[n7][n5] = byArray[n3++];
                    if (a[n7][n5] == 0 || a[n7][n5] == 3) {
                        d.a[n7][n5 + 1] = byArray[n3++];
                        d.a[n7][n5 + 2] = byArray[n3++];
                        d.a[n7][n5 + 3] = byArray[n3++];
                        continue;
                    }
                    if (a[n7][n5] != 1 && a[n7][n5] != 4 && a[n7][n5] != 5 && a[n7][n5] != 9 && a[n7][n5] != 10) continue;
                    d.a[n7][n5 + 1] = byArray[n3++];
                    if (a[n7][n5] != 1) continue;
                    d.r(a[n7][n5 + 1]);
                }
            }
            B = byArray[n3++];
            r = new byte[B];
            b = new byte[B][];
            for (n7 = 0; n7 < B; ++n7) {
                d.r[n7] = byArray[n3++];
                d.b[n7] = new byte[byArray[n3++] * 4];
                for (n5 = 0; n5 < b[n7].length; n5 += 4) {
                    d.b[n7][n5] = byArray[n3++];
                    if (b[n7][n5] == 0 || b[n7][n5] == 3) {
                        d.b[n7][n5 + 1] = byArray[n3++];
                        d.b[n7][n5 + 2] = byArray[n3++];
                        d.b[n7][n5 + 3] = byArray[n3++];
                        continue;
                    }
                    if (b[n7][n5] != 1 && b[n7][n5] != 4 && b[n7][n5] != 5 && b[n7][n5] != 9 && b[n7][n5] != 10) continue;
                    d.b[n7][n5 + 1] = byArray[n3++];
                    if (b[n7][n5] != 1) continue;
                    d.r(b[n7][n5 + 1]);
                }
            }
            n8 = byArray[n3++] & 0xFF;
            n7 = 1;
            if (n8 == 0) {
                i = new byte[byArray2.length];
                for (n5 = 0; n5 < byArray2.length; ++n5) {
                    d.i[n5] = byArray2[n5];
                }
                n7 = 0;
            }
            if (n7 != 0) {
                n6 = byArray[n3++] & 0xFF;
                i = new byte[n6 + byArray2.length + 1 - B];
                for (n5 = 0; n5 < byArray2.length; ++n5) {
                    d.i[n5] = byArray2[n5];
                }
                j = new byte[(n6 + 1 - B) * 2];
                for (n4 = 0; n4 < n8; ++n4) {
                    n5 = byArray[n3++] & 0xFF;
                    d.j[(n5 - d.B) * 2] = byArray[n3++];
                    d.j[(n5 - d.B) * 2 + 1] = byArray[n3++];
                    d.i[n5] = byArray[n3++];
                }
            }
        }
        catch (Exception exception) {}
        b.b(10);
    }

    private static void r(int n2) {
        if ((n2 &= 0xFF) < F && n2 > 66) {
            F = n2;
        }
        if (n2 > G) {
            G = n2;
        }
    }

    private void l() {
        if (A == 0) {
            d.a[3] = 0;
        }
        k.a = (byte)(k.a + 1);
        k.a = b;
        k.a[0] = a[0];
        k.a[1] = a[1];
        k.a[2] = a[2];
        k.a[3] = a[3];
        k.a.a = false;
        k.a();
        h.a(11, this);
    }

    private void m() {
        f = true;
        d.a[3] = K;
        k.a.a = false;
        h.a(10, this);
    }

    public static final void d() {
        g = true;
    }

    public static final void e() {
        g = false;
    }

    /*
     * Exception decompiling
     */
    public static final boolean a(byte var0, byte var1_1, byte var2_2, byte var3_3) {
        /*
         * This method has failed to decompile.  When submitting a bug report, please provide this stack trace, and (if you hold appropriate legal rights) the relevant class file.
         * 
         * org.benf.cfr.reader.util.ConfusedCFRException: Tried to end blocks [1[DOLOOP]], but top level block is 5[FORLOOP]
         *     at org.benf.cfr.reader.bytecode.analysis.opgraph.Op04StructuredStatement.processEndingBlocks(Op04StructuredStatement.java:435)
         *     at org.benf.cfr.reader.bytecode.analysis.opgraph.Op04StructuredStatement.buildNestedBlocks(Op04StructuredStatement.java:484)
         *     at org.benf.cfr.reader.bytecode.analysis.opgraph.Op03SimpleStatement.createInitialStructuredBlock(Op03SimpleStatement.java:736)
         *     at org.benf.cfr.reader.bytecode.CodeAnalyser.getAnalysisInner(CodeAnalyser.java:850)
         *     at org.benf.cfr.reader.bytecode.CodeAnalyser.getAnalysisOrWrapFail(CodeAnalyser.java:278)
         *     at org.benf.cfr.reader.bytecode.CodeAnalyser.getAnalysis(CodeAnalyser.java:201)
         *     at org.benf.cfr.reader.entities.attributes.AttributeCode.analyse(AttributeCode.java:94)
         *     at org.benf.cfr.reader.entities.Method.analyse(Method.java:531)
         *     at org.benf.cfr.reader.entities.ClassFile.analyseMid(ClassFile.java:1055)
         *     at org.benf.cfr.reader.entities.ClassFile.analyseTop(ClassFile.java:942)
         *     at org.benf.cfr.reader.Driver.doClass(Driver.java:84)
         *     at org.benf.cfr.reader.CfrDriverImpl.analyse(CfrDriverImpl.java:78)
         *     at org.benf.cfr.reader.Main.main(Main.java:54)
         */
        throw new IllegalStateException("Decompilation failed");
    }

    private static boolean a(int n2, byte by, byte by2) {
        int n3 = d.a();
        if (n3 <= 0) {
            return false;
        }
        int n4 = n3 - (d[n2].length - 1);
        int n5 = n4 > 0 ? d[n2].length - 1 : n3;
        d.J[n2] = (byte)n5;
        d.w[n2] = 0;
        int n6 = d.b();
        --n5;
        while (true) {
            if (n4 <= 0) {
                d.d[n2][n5] = (byte)(n6 % b);
                d.e[n2][n5] = (byte)(n6 / b);
                --n5;
            } else {
                --n4;
            }
            if (n6 == b[n6]) break;
            n6 = b[n6];
        }
        return true;
    }

    public static final int a() {
        int n2 = d.b();
        if (n2 <= 0) {
            return 1;
        }
        int n3 = 0;
        while (true) {
            ++n3;
            if (n2 == b[n2]) break;
            n2 = b[n2];
        }
        return n3;
    }

    public static final int b() {
        return a;
    }

    private static boolean a(int n2, int n3, boolean bl) {
        if (n2 < 0 || n3 < 0 || n2 >= b || n3 >= c) {
            return true;
        }
        return (i[d.a((byte)n2, (byte)n3)] & 1) == 0;
    }

    public final void a() {
        e = true;
        a = this;
    }

    static {
        a = new int[]{1500, 1500, 1000, 250};
        t = 0;
        u = 0;
        v = 128;
        w = 108;
        b = new byte[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 1, 1, 1, 2, 0, 0, 0, 0, 2, 1, 1, 1, 2, 0, 0, 0, 0, 2, 5, 5, 5, 2, 0, 0, 0, 0, 3, 3, 3, 3, 3, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
        c = new byte[]{0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2, 1, 1, 1, 2, 0, 0, 4, 3, 3, 5, 1, 1, 2, 0, 0, 4, 3, 3, 5, 5, 1, 2, 0, 0, 4, 3, 3, 3, 3, 2, 0, 0, 0, 4, 4, 3, 3, 3, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
        d = new byte[]{7, 7, 7, 0, 0, 0, 1, 1, 1, 7, 7, 7, 0, 0, 0, 1, 1, 1, 7, 7, 7, 7, 0, 1, 1, 1, 1, 6, 6, 7, 7, 0, 1, 1, 2, 2, 6, 6, 6, 6, 0, 2, 2, 2, 2, 6, 6, 5, 5, 4, 3, 3, 2, 2, 5, 5, 5, 5, 4, 3, 3, 3, 3, 5, 5, 5, 4, 4, 4, 3, 3, 3, 5, 5, 5, 4, 4, 4, 3, 3, 3};
        e = new byte[]{6, 6, 4, 2, 1};
        f = new byte[]{100, 100, 80, 60, 40};
        b = new int[]{100, 103, 104, 106, 108, 109, 110, 111, 112, 121, 124, 125, 127, 129, 130, 131, 132, 133, 151, 154, 155, 157, 159, 160, 161, 162, 163, 85, -1, -1, -1, -1, -1, -1, -1};
        int[] nArray = new int[]{0, 78, -1, -1, 1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, -1, -1, -1, -1, -1, -1};
        z = 0;
        A = -1;
        l = new int[]{0, 0, 0, 0};
        d = new int[12];
    }
}
