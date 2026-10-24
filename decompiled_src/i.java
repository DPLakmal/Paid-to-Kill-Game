/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  com.nokia.mid.sound.Sound
 */
import com.nokia.mid.sound.Sound;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class i {
    private static boolean a = true;
    private static Sound a = null;
    private static byte[][] a = new byte[0][];
    private static int[] a = new int[0];

    private i() {
    }

    public static final void a(byte[] byArray, int n) {
        byte[][] byArrayArray = new byte[a.length + 1][];
        System.arraycopy(a, 0, byArrayArray, 0, a.length);
        a = byArrayArray;
        i.a[i.a.length - 1] = byArray;
        int[] nArray = new int[a.length + 1];
        System.arraycopy(a, 0, nArray, 0, a.length);
        a = nArray;
        i.a[i.a.length - 1] = n;
    }

    public static final void a(int n, int n2) {
        i.a();
        if (a) {
            int n3 = -1;
            for (int j = 0; j < a.length; ++j) {
                if (a[j] != n) continue;
                n3 = j;
                break;
            }
            if (n3 == -1) {
                return;
            }
            try {
                a = new Sound(a[n3], 1);
                if (n2 == -1) {
                    n2 = 0;
                } else if (n2 > 254) {
                    n2 = 254;
                }
                a.play(n2);
                return;
            }
            catch (Exception exception) {}
        }
    }

    public static final void a() {
        if (a && a != null) {
            try {
                a.stop();
            }
            catch (Exception exception) {}
            a = null;
        }
    }

    public static final void a(boolean bl) {
        if (!bl) {
            i.a();
        }
        a = bl;
    }

    public static final boolean a() {
        return a;
    }
}
