/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Display
 *  javax.microedition.lcdui.Displayable
 *  javax.microedition.lcdui.Graphics
 *  javax.microedition.midlet.MIDlet
 *  javax.microedition.rms.RecordStore
 */
import a.f;
import java.util.Vector;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Graphics;
import javax.microedition.midlet.MIDlet;
import javax.microedition.rms.RecordStore;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class h
implements Runnable {
    public static MIDlet a;
    public static j a;
    public static k a;
    public static n a;
    private static n b;
    private static int[] a;
    private final int b;
    private static Vector a;
    private static int c;
    private static int d;
    private static int e;
    public static int a;

    private h(int n2) {
        this.b = n2;
        new Thread(this).start();
    }

    public static final void a(int n2) {
        if ((n2 == 11 || n2 == 12) && a != 1) {
            return;
        }
        switch (n2) {
            case 1: {
                new h(2);
                return;
            }
            case 3: 
            case 11: {
                if (e == 3) {
                    e = 4;
                    new h(3);
                    return;
                }
                if (e != 6) break;
                e = 4;
                return;
            }
            case 2: 
            case 12: {
                if (e == 2) {
                    a.a(2);
                    e = 3;
                    return;
                }
                if (e != 4) break;
                e = 6;
            }
        }
    }

    public static final int a(int n2, Object object) {
        Object[] objectArray = new Object[3];
        Object[] objectArray2 = objectArray;
        objectArray[0] = new Integer(n2);
        objectArray2[1] = new Integer(++c);
        objectArray2[2] = object;
        a.addElement(objectArray2);
        return c;
    }

    public static final boolean a(int n2) {
        return n2 <= d;
    }

    public static final void a(n n2) {
        b = n2;
    }

    public static final n a() {
        return a;
    }

    public static final void a() {
        e = 7;
        new h(4);
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     * Enabled aggressive block sorting
     * Enabled unnecessary exception pruning
     * Enabled aggressive exception aggregation
     * Converted monitor instructions to comments
     * Lifted jumps to return sites
     */
    public final void run() {
        block45: {
            long l;
            block46: {
                boolean bl = false;
                try {
                    Object[] objectArray = a;
                    // MONITORENTER : a
                    if (a[this.b] == 3) {
                        // MONITOREXIT : objectArray
                        return;
                    }
                    h.a[this.b] = 2;
                    // MONITOREXIT : objectArray
                    if (this.b == 2) {
                        a = new Vector(5);
                        a = new j();
                        f.a(Display.getDisplay((MIDlet)a), (Displayable)a);
                        n.b = a.getWidth();
                        n.c = a.getHeight();
                        g.a();
                        for (int i2 = 0; i2 < 5; ++i2) {
                            h.a[i2] = 1;
                        }
                        new h(0);
                        new h(1);
                        a = g.a();
                        e = 2;
                        a.a(1);
                        break block45;
                    }
                    if (this.b == 3) {
                        Thread.sleep(700L);
                        if (e == 4) {
                            e = 5;
                            try {
                                a.a(3);
                            }
                            catch (Throwable throwable) {}
                            e = 2;
                            break block45;
                        }
                        e = 3;
                        break block45;
                    }
                    if (this.b == 4) {
                        try {
                            objectArray = a;
                            // MONITORENTER : a
                            for (int i3 = 0; i3 < 5; ++i3) {
                                if (a[i3] != 2) continue;
                                h.a[i3] = 3;
                            }
                            // MONITOREXIT : objectArray
                            try {
                                a.a(4);
                            }
                            catch (Throwable throwable) {}
                            h.a[4] = 1;
                            boolean bl2 = true;
                            long l2 = System.currentTimeMillis();
                            while (bl2 && System.currentTimeMillis() - l2 < 1500L) {
                                bl2 = false;
                                for (int i4 = 0; i4 < 5; ++i4) {
                                    bl2 = bl2 || a[i4] != 1;
                                }
                                try {
                                    Thread.sleep(100L);
                                }
                                catch (InterruptedException interruptedException) {}
                            }
                        }
                        catch (Throwable throwable) {}
                        f.b(4);
                        break block45;
                    }
                    if (this.b == 0) {
                        l = System.currentTimeMillis();
                        break block46;
                    }
                    if (this.b != 1) break block45;
                    while (a[this.b] == 2) {
                        while (e == 3) {
                            try {
                                Thread.sleep(100L);
                            }
                            catch (InterruptedException interruptedException) {}
                        }
                        if (!a.isEmpty()) {
                            objectArray = (Object[])a.firstElement();
                            a.removeElementAt(0);
                            try {
                                g.a(objectArray[0], objectArray[2]);
                            }
                            catch (Throwable throwable) {}
                            d = objectArray[1];
                        }
                        Thread.yield();
                    }
                    break block45;
                }
                catch (Throwable throwable) {
                    if (a[this.b] != 2 || this.b != 0 && this.b != 1) break block45;
                    try {
                        Thread.sleep(200L);
                    }
                    catch (InterruptedException interruptedException) {}
                    new h(this.b);
                    return;
                }
            }
            while (a[this.b] == 2) {
                while (e == 3) {
                    try {
                        Thread.sleep(100L);
                    }
                    catch (InterruptedException interruptedException) {}
                }
                if (a != null) {
                    a.repaint();
                    a.serviceRepaints();
                    long l3 = System.currentTimeMillis() - l;
                    if (l3 > 500L) {
                        l3 = 500L;
                    }
                    l = System.currentTimeMillis();
                    a.c((int)l3);
                } else {
                    l = System.currentTimeMillis();
                }
                if (a != b) {
                    a = b;
                    for (int i5 = 0; i5 < 2; ++i5) {
                        a.a(a != null ? h.a.a[i5] : null, i5);
                    }
                    n n2 = a;
                    if (n2 != null) {
                        h.a.a = n2.d;
                        n2.a();
                    }
                }
                Thread.yield();
            }
        }
        int[] nArray = a;
        // MONITORENTER : a
        h.a[this.b] = 1;
        // MONITOREXIT : nArray
    }

    /*
     * Enabled aggressive block sorting
     * Enabled unnecessary exception pruning
     * Enabled aggressive exception aggregation
     */
    public static final byte[] a(String string) throws Exception {
        byte[] byArray;
        RecordStore recordStore = null;
        try {
            recordStore = RecordStore.openRecordStore((String)string, (boolean)false);
            if (recordStore == null) throw new NullPointerException();
            if (recordStore.getNumRecords() < 1) {
                throw new NullPointerException();
            }
            byArray = recordStore.getRecord(1);
        }
        catch (Exception exception) {
            try {
                Exception exception2 = exception;
                throw exception;
            }
            catch (Throwable throwable) {
                try {
                    if (recordStore == null) throw throwable;
                    recordStore.closeRecordStore();
                    throw throwable;
                }
                catch (Exception exception2) {}
                throw throwable;
            }
        }
        try {
            if (recordStore == null) return byArray;
            recordStore.closeRecordStore();
            return byArray;
        }
        catch (Exception exception) {
            return byArray;
        }
    }

    /*
     * Enabled aggressive block sorting
     * Enabled unnecessary exception pruning
     * Enabled aggressive exception aggregation
     */
    public static final void a(byte[] byArray, String string) throws Exception {
        RecordStore recordStore = null;
        try {
            recordStore = RecordStore.openRecordStore((String)string, (boolean)true);
            if (recordStore.getNumRecords() < 1) {
                recordStore.addRecord(null, 0, 0);
            }
            recordStore.setRecord(1, byArray, 0, byArray.length);
        }
        catch (Exception exception) {
            try {
                Exception exception2 = exception;
                throw exception;
            }
            catch (Throwable throwable) {
                try {
                    if (recordStore == null) throw throwable;
                    recordStore.closeRecordStore();
                    throw throwable;
                }
                catch (Exception exception2) {}
                throw throwable;
            }
        }
        try {
            if (recordStore == null) return;
            recordStore.closeRecordStore();
            return;
        }
        catch (Exception exception) {}
    }

    public static final boolean a(Graphics graphics, int n2, int n3, int n4, int n5, int[] nArray) {
        int n6 = graphics.getClipX();
        int n7 = graphics.getClipY();
        int n8 = graphics.getClipWidth();
        int n9 = graphics.getClipHeight();
        nArray[0] = n6;
        nArray[1] = n7;
        nArray[2] = n8;
        nArray[3] = n9;
        if (n2 < n6) {
            n4 -= n6 - n2;
            n2 = n6;
        }
        if (n3 < n7) {
            n5 -= n7 - n3;
            n3 = n7;
        }
        if (n2 + n4 > n6 + n8) {
            n4 = n6 + n8 - n2;
        }
        if (n3 + n5 > n7 + n9) {
            n5 = n7 + n9 - n3;
        }
        if (n4 > 0 && n5 > 0) {
            graphics.setClip(n2, n3, n4, n5);
            return true;
        }
        return false;
    }

    static {
        a = null;
        b = null;
        a = new int[5];
        c = 0;
        d = 0;
        e = 1;
        a = 1;
    }
}
