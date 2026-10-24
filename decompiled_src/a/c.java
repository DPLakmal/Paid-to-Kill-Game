/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Command
 *  javax.microedition.lcdui.CommandListener
 *  javax.microedition.lcdui.Displayable
 *  javax.microedition.lcdui.Form
 *  javax.microedition.lcdui.Gauge
 *  javax.microedition.lcdui.Item
 *  javax.microedition.rms.RecordStoreException
 */
package a;

import a.b;
import a.f;
import a.h;
import a.i;
import a.j;
import a.k;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Hashtable;
import java.util.Vector;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Gauge;
import javax.microedition.lcdui.Item;
import javax.microedition.rms.RecordStoreException;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public class c
extends b
implements h,
Runnable,
CommandListener {
    private transient String a;
    private Command a;
    private Command b;
    private Command c;
    private Command d;
    private Hashtable a;
    private byte[] a = new Hashtable();

    public static void a() {
        try {
            c c2 = new c();
            f.a = c2;
            c2.d();
        }
        catch (Exception exception) {
            // empty catch block
        }
    }

    public static void b() {
        c c2 = (c)f.a;
        try {
            c2.e();
        }
        catch (Exception exception) {
            c2.a(exception);
            f.a("Connection failed", null);
            f.a.notifyDestroyed();
        }
        if (c2.a(103) == 6L) {
            f.a(c2.b((short)30), null);
            f.a.notifyDestroyed();
        }
        c2.a((short)3, -1, -1, null);
    }

    public static final int[] a(DataInputStream dataInputStream) throws IOException {
        if (null == dataInputStream) {
            return new int[0];
        }
        int[] nArray = new int[dataInputStream.readInt()];
        for (int j = 0; j < nArray.length; ++j) {
            nArray[j] = dataInputStream.readInt();
        }
        return nArray;
    }

    private final k b(int n) throws IOException, RecordStoreException {
        Object object = this.a(5, n);
        if (null != object) {
            k k2 = new k();
            k2.a = n;
            k2.c = 0;
            k2.d = ((DataInputStream)object).readInt();
            k2.a = new byte[k2.d];
            ((DataInputStream)object).readFully(k2.a);
            k2.a = a.c.a((DataInputStream)object);
            return k2;
        }
        return null;
    }

    public k a(int n) {
        try {
            if (!this.a()) {
                int n2;
                int n3;
                int n4 = (int)this.a((short)7, n, 0L);
                Vector<Integer> vector = new Vector<Integer>();
                int[] nArray = a.c.a((DataInputStream)this.a(3, n));
                for (n3 = 0; n3 < nArray.length; ++n3) {
                    int[] nArray2 = a.c.a((DataInputStream)this.a(4, nArray[n3]));
                    for (n2 = 0; n2 < nArray2.length; ++n2) {
                        vector.addElement(new Integer(nArray2[n2]));
                    }
                }
                n3 = n4;
                int n5 = vector.size();
                n2 = 0;
                while (n2 < n5) {
                    int n6 = (Integer)vector.elementAt(n3 %= n5);
                    k k2 = this.b(n6);
                    if (null != k2 && this.a(n6)) {
                        this.a(7, n, (byte)1, n4 + 1);
                        return k2;
                    }
                    ++n2;
                    ++n3;
                }
                this.a(true);
            }
            this.a((short)9, n, -1, null);
        }
        catch (Exception exception) {
            this.a(exception);
        }
        return null;
    }

    public String a(int n) {
        try {
            byte[] byArray = this.a(6, n);
            DataInputStream dataInputStream = a.b.a(byArray);
            if (null != dataInputStream) {
                dataInputStream.readInt();
                int n2 = dataInputStream.readInt();
                i i2 = f.a(n2);
                if (i2 != null) {
                    return i2.a(byArray, 8, byArray.length - 8);
                }
            }
        }
        catch (Exception exception) {
            this.a(exception);
        }
        return this.b((short)6);
    }

    public void a(int n, k k2, int n2) {
        try {
            int n3;
            i i2;
            byte[] byArray = this.a(6, n2);
            DataInputStream dataInputStream = a.b.a(byArray);
            if (null != dataInputStream && (i2 = f.a(n3 = dataInputStream.readInt())) != null) {
                i2.a(n, k2.a, n2, byArray, 8, byArray.length - 8);
            }
        }
        catch (Exception exception) {
            this.a(exception);
        }
    }

    public void a(k k2) {
        this.c(k2.b);
        this.a((short)1, k2.a, -1, null);
    }

    public void c() {
        try {
            this.b(0, 7);
            this.d();
        }
        catch (Exception exception) {
            // empty catch block
        }
    }

    public void d() throws Exception {
        this.a = this.a(1, 109);
    }

    private boolean a(int n) {
        try {
            DataInputStream dataInputStream = a.b.a(this.a);
            if (null != dataInputStream) {
                byte by = dataInputStream.readByte();
                for (byte by2 = 0; by2 < by; by2 = (byte)(by2 + 1)) {
                    int n2 = dataInputStream.readInt();
                    if (n == n2) {
                        byte by3 = dataInputStream.readByte();
                        int n3 = dataInputStream.readUnsignedByte() << 16 | dataInputStream.readUnsignedShort();
                        return !(by3 != -1 && by3 <= 0 || n3 != 0xFFFFFF && a.b.b() / 60 > n3);
                    }
                    f.a(dataInputStream, 4);
                }
            }
            return true;
        }
        catch (Exception exception) {
            this.a(exception);
            return true;
        }
    }

    private void c(int n) {
        try {
            DataInputStream dataInputStream = a.b.a(this.a);
            if (null != dataInputStream) {
                byte by = dataInputStream.readByte();
                for (byte by2 = 0; by2 < by; by2 = (byte)(by2 + 1)) {
                    int n2 = dataInputStream.readInt();
                    byte by3 = dataInputStream.readByte();
                    f.a(dataInputStream, 3);
                    if (n != n2) continue;
                    if (by3 > 0) {
                        this.a[1 + by2 * 8 + 4] = (byte)(by3 - 1);
                        this.a(1, 109, (byte)1, this.a);
                    }
                    return;
                }
            }
        }
        catch (Exception exception) {
            this.a(exception);
        }
    }

    private void a(boolean bl) {
        this.a((short)110, bl ? 1L : 0L);
    }

    private boolean a() {
        long l = this.a(110);
        boolean bl = 0L != l;
        return bl;
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    private void g() throws RecordStoreException, IOException {
        if (this.a(120) != 2L) {
            this.c();
            this.a("/gswrap.rc");
            this.a((short)104, String.valueOf(System.currentTimeMillis()));
            DataInputStream dataInputStream = this.a("/.gsid");
            try {
                this.a((short)111, (long)dataInputStream.readInt());
                this.a((short)114, (long)dataInputStream.readInt());
                this.a((short)112, (long)dataInputStream.readInt());
                this.a((short)121, dataInputStream.readLong());
                this.a((short)113, (long)f.a);
                this.a((short)120, 2L);
                this.a(dataInputStream);
            }
            finally {
                dataInputStream.close();
            }
        }
        this.a = new Command(this.b((short)1), 4, 1);
        this.b = new Command(this.b((short)2), 7, 1);
        this.c = new Command(this.b((short)3), 7, 1);
        this.d = new Command(this.b((short)4), 4, 1);
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    private boolean a(String string) throws IOException, RecordStoreException {
        DataInputStream dataInputStream = this.a(string);
        if (null != dataInputStream) {
            try {
                this.a(dataInputStream);
                boolean bl = true;
                return bl;
            }
            finally {
                dataInputStream.close();
            }
        }
        return false;
    }

    private void h() throws RecordStoreException, IOException {
        this.a((short)5, System.getProperty("microedition.platform"));
        this.a((short)6, System.getProperty("microedition.profiles"));
        this.a((short)2, (long)j.b());
        this.a((short)3, (long)j.a());
        this.a((short)1, (long)this.a());
    }

    public void run() {
        int n = 0;
        Throwable throwable = null;
        for (int i2 = 0; i2 < 4; ++i2) {
            try {
                this.b(0);
                this.a(i2);
                this.d();
                this.b(100);
                return;
            }
            catch (RecordStoreException recordStoreException) {
                try {
                    this.b(2, 2);
                }
                catch (Exception exception) {
                    // empty catch block
                }
                this.a(recordStoreException);
                throwable = recordStoreException;
                n = 1;
                continue;
            }
            catch (SecurityException securityException) {
                this.a(securityException);
                throwable = securityException;
                n = 2;
                continue;
            }
            catch (IOException iOException) {
                this.a(iOException);
                throwable = iOException;
                n = 3;
                continue;
            }
            catch (Exception exception) {
                this.a(exception);
                n = 4;
                throwable = exception;
            }
        }
        if (!((b)this).a) {
            this.a((short)115, (long)n);
            this.a((short)116, throwable.toString());
            this.i();
        }
    }

    private final void i() {
        long l = this.a(114);
        long l2 = this.a(111);
        long l3 = this.a(112);
        long l4 = this.a(115);
        String string = this.a((short)116);
        long l5 = this.a(107) - this.a(108);
        Object[] objectArray = new Object[]{new Long(l4), new Long(l5), new Long(l), new Long(l2), new Long(l3), new Long(l4), string};
        Form form = new Form(this.a((short)20, objectArray));
        form.setCommandListener((CommandListener)this);
        form.append(this.a((short)21, objectArray));
        this.a = "http://wap.greystripe.com/error.php?id=" + l4 + "." + l + "." + l2 + "." + l3 + "." + f.a(string.getBytes());
        form.addCommand(this.d);
        if (l5 <= 0L) {
            form.addCommand(this.b);
        } else {
            form.append(this.a((short)22, objectArray));
            form.addCommand(this.c);
        }
        f.a((Displayable)form);
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public void e() throws IOException, RecordStoreException {
        boolean bl;
        this.g();
        this.h();
        long l = this.a(103);
        boolean bl2 = l == 6L;
        boolean bl3 = l == 5L;
        long l2 = this.a(106);
        long l3 = this.a(108);
        this.a((short)108, l3 + 1L);
        boolean bl4 = bl = !bl3 && (bl2 || this.a() || l3 >= l2 || this.a(115) != 0L);
        if (bl) {
            this.a((short)8, -1, -1, null);
            ((b)this).a = -1;
            Form form = new Form(this.b((short)10));
            form.append(this.b((short)11));
            form.setCommandListener((CommandListener)this);
            form.addCommand(this.a);
            f.a((Displayable)form);
            try {
                c c2 = this;
                synchronized (c2) {
                    try {
                        while (((b)this).a < 0) {
                            this.wait();
                        }
                        form.removeCommand(this.a);
                        Gauge gauge = new Gauge(this.b((short)31), false, 99, 0);
                        form.insert(0, (Item)gauge);
                        ((b)this).a = 0;
                        new Thread(this).start();
                        while (((b)this).a < 100) {
                            this.wait();
                            gauge.setValue(((b)this).a);
                        }
                    }
                    catch (InterruptedException interruptedException) {
                        // empty catch block
                    }
                }
            }
            finally {
                f.c();
            }
        }
    }

    public void commandAction(Command command, Displayable displayable) {
        if (command == this.a) {
            this.b(0);
        } else if (command == this.b) {
            f.a.notifyDestroyed();
        } else if (command == this.d) {
            f.a(this.a);
        } else if (command == this.c) {
            f.c();
            this.b(100);
        }
    }

    public DataInputStream a(String string) throws IOException {
        InputStream inputStream = f.a.getClass().getResourceAsStream(string);
        if (null != inputStream) {
            return new DataInputStream(inputStream);
        }
        throw new IOException("Cannot load " + string);
    }

    public void f() {
        if (((b)this).a == 100) {
            ((b)this).a = true;
            new Thread(this).start();
        }
    }
}
