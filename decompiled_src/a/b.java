/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.io.Connector
 *  javax.microedition.io.HttpConnection
 *  javax.microedition.io.StreamConnection
 *  javax.microedition.rms.RecordEnumeration
 *  javax.microedition.rms.RecordStore
 *  javax.microedition.rms.RecordStoreException
 */
package a;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.FilterInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Hashtable;
import javax.microedition.io.Connector;
import javax.microedition.io.HttpConnection;
import javax.microedition.io.StreamConnection;
import javax.microedition.rms.RecordEnumeration;
import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public class b {
    private StreamConnection a;
    public boolean a;
    private RecordStore a;
    private Hashtable a;
    public transient int a = new Hashtable();

    public b() {
        try {
            this.a = RecordStore.openRecordStore((String)"GSWRP", (boolean)true);
            this.a();
        }
        catch (Exception exception) {
            // empty catch block
        }
    }

    public DataOutputStream a(int n) throws IOException, RecordStoreException {
        long l = (long)n + 100L * this.a(119);
        Object[] objectArray = new Object[]{new Long(System.currentTimeMillis()), new Long(l)};
        if (l == 0L) {
            this.a = (StreamConnection)Connector.open((String)this.a((short)8, objectArray));
            DataOutputStream dataOutputStream = this.a.openDataOutputStream();
            byte[] byArray = this.a((short)7, objectArray).getBytes();
            dataOutputStream.write(byArray, 0, byArray.length);
            return dataOutputStream;
        }
        HttpConnection httpConnection = (HttpConnection)Connector.open((String)this.a((short)9, objectArray));
        httpConnection.setRequestMethod("POST");
        httpConnection.setRequestProperty("Content-Type", "application/octet-stream");
        this.a = httpConnection;
        return this.a.openDataOutputStream();
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public void a(int n) throws RecordStoreException, IOException {
        DataOutputStream dataOutputStream = this.a(n);
        FilterInputStream filterInputStream = null;
        try {
            dataOutputStream.writeInt(1465008464);
            if (!this.a) {
                this.a(dataOutputStream, 0, 7);
                dataOutputStream.writeByte(2);
            } else {
                this.a(dataOutputStream, 1, 2);
            }
            dataOutputStream.writeByte(3);
            dataOutputStream.flush();
            this.b(50);
            filterInputStream = this.a.openDataInputStream();
            try {
                this.a((DataInputStream)filterInputStream);
            }
            finally {
                filterInputStream.close();
            }
        }
        finally {
            try {
                if (null != dataOutputStream) {
                    dataOutputStream.close();
                }
                if (null != filterInputStream) {
                    filterInputStream.close();
                }
            }
            finally {
                this.a.close();
            }
        }
    }

    public void a(DataInputStream dataInputStream) throws IOException, RecordStoreException {
        int n;
        block5: while ((n = dataInputStream.read()) != 3) {
            switch (n) {
                case -1: {
                    throw new EOFException("Expecting close.");
                }
                case 4: {
                    this.b(dataInputStream);
                    continue block5;
                }
                case 5: {
                    int n2 = dataInputStream.readInt();
                    int n3 = dataInputStream.readUnsignedByte();
                    this.a(n3, n2);
                    continue block5;
                }
            }
            throw new IOException("Invalid command.");
        }
    }

    public int a() throws RecordStoreException {
        return this.a.getSizeAvailable();
    }

    public static final DataInputStream a(byte[] byArray) {
        if (null != byArray && byArray.length > 0) {
            return new DataInputStream(new ByteArrayInputStream(byArray));
        }
        return null;
    }

    public void a(int n, int n2, byte by, String string) {
        try {
            if (null != string) {
                this.a(n, n2, by, b.a(string));
            } else {
                this.a(n, n2);
            }
        }
        catch (Exception exception) {
            this.a(exception);
        }
    }

    public void a(short s, String string) {
        try {
            this.a(1, (int)s, (byte)0, string);
        }
        catch (Exception exception) {
            this.a(exception);
        }
    }

    public void a(short s, long l) {
        try {
            this.a(1, (int)s, (byte)0, l);
        }
        catch (Exception exception) {
            this.a(exception);
        }
    }

    public void a(int n, int n2, byte by, long l) {
        try {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream(8);
            DataOutputStream dataOutputStream = new DataOutputStream(byteArrayOutputStream);
            dataOutputStream.writeLong(l);
            this.a(n, n2, by, byteArrayOutputStream.toByteArray());
        }
        catch (Exception exception) {
            this.a(exception);
        }
    }

    private static final Object a(int n, int n2) {
        return n + "." + n2;
    }

    public void a(int n, int n2, byte by, byte[] byArray) throws RecordStoreException, IOException {
        if (0 == n2) {
            n2 = this.a.getNextRecordID();
        }
        Object object = b.a(n, n2);
        Integer n3 = (Integer)this.a.get(object);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream(byArray.length + 1 + 4 + 1);
        DataOutputStream dataOutputStream = new DataOutputStream(byteArrayOutputStream);
        dataOutputStream.writeInt(n2);
        dataOutputStream.writeByte(n);
        dataOutputStream.writeByte(by);
        ((OutputStream)dataOutputStream).write(byArray);
        byte[] byArray2 = byteArrayOutputStream.toByteArray();
        if (null != n3) {
            this.a.setRecord(n3.intValue(), byArray2, 0, byArray2.length);
        } else {
            n3 = new Integer(this.a.addRecord(byArray2, 0, byArray2.length));
            this.a.put(object, n3);
        }
    }

    public long a(short s, int n, long l) {
        try {
            Object object = this.a(s, n);
            if (null != object) {
                return ((DataInputStream)object).readLong();
            }
        }
        catch (Exception exception) {
            this.a(exception);
        }
        return l;
    }

    public DataInputStream a(int n, int n2) throws IOException, RecordStoreException {
        return b.a(this.a(n, n2));
    }

    public String a(short s, int n) {
        try {
            byte[] byArray = this.a((int)s, n);
            if (null != byArray) {
                return b.a(byArray);
            }
        }
        catch (Exception exception) {
            this.a(exception);
        }
        return null;
    }

    public byte[] a(int n, int n2) throws RecordStoreException, IOException {
        Object object = b.a(n, n2);
        Integer n3 = (Integer)this.a.get(object);
        if (null != n3) {
            byte[] byArray = this.a.getRecord(n3.intValue());
            byte[] byArray2 = new byte[byArray.length - 6];
            System.arraycopy(byArray, 6, byArray2, 0, byArray2.length);
            return byArray2;
        }
        return null;
    }

    public void a(int n, int n2) throws RecordStoreException {
        Object object = b.a(n, n2);
        Integer n3 = (Integer)this.a.remove(object);
        if (null != n3) {
            this.a.deleteRecord(n3.intValue());
        }
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    private void a() throws RecordStoreException, IOException {
        RecordEnumeration recordEnumeration = this.a.enumerateRecords(null, null, false);
        try {
            while (recordEnumeration.hasNextElement()) {
                int n = recordEnumeration.nextRecordId();
                DataInputStream dataInputStream = b.a(this.a.getRecord(n));
                int n2 = dataInputStream.readInt();
                int n3 = dataInputStream.readUnsignedByte();
                Object object = b.a(n3, n2);
                if (this.a.containsKey(object)) {
                    this.a.deleteRecord(n);
                    continue;
                }
                this.a.put(object, new Integer(n));
            }
        }
        finally {
            recordEnumeration.destroy();
        }
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public void a(DataOutputStream dataOutputStream, int n, int n2) throws RecordStoreException, IOException {
        int n3 = 50000 / this.a.getNumRecords();
        int n4 = 0;
        RecordEnumeration recordEnumeration = this.a.enumerateRecords(null, null, false);
        try {
            while (recordEnumeration.hasNextElement()) {
                this.b((n4 += n3) / 1000);
                byte[] byArray = recordEnumeration.nextRecord();
                byte by = byArray[4];
                byte by2 = byArray[5];
                if (by < n || by > n2 || by2 == 1) continue;
                dataOutputStream.writeByte(1);
                dataOutputStream.writeShort(byArray.length);
                if (by2 == 2) {
                    dataOutputStream.write(byArray, 0, 6);
                    continue;
                }
                ((OutputStream)dataOutputStream).write(byArray);
            }
        }
        finally {
            recordEnumeration.destroy();
        }
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public void b(int n, int n2) throws RecordStoreException, IOException {
        RecordEnumeration recordEnumeration = this.a.enumerateRecords(null, null, false);
        try {
            while (recordEnumeration.hasNextElement()) {
                int n3 = recordEnumeration.nextRecordId();
                DataInputStream dataInputStream = b.a(this.a.getRecord(n3));
                int n4 = dataInputStream.readInt();
                int n5 = dataInputStream.readUnsignedByte();
                if (n5 < n || n5 > n2) continue;
                this.a(n5, n4);
            }
        }
        finally {
            recordEnumeration.destroy();
        }
    }

    private void b(DataInputStream dataInputStream) throws RecordStoreException, IOException {
        int n;
        int n2 = dataInputStream.readInt();
        int n3 = dataInputStream.readUnsignedByte();
        byte by = dataInputStream.readByte();
        byte[] byArray = new byte[dataInputStream.readUnsignedShort()];
        for (int i = 0; i < byArray.length; i += n) {
            n = dataInputStream.read(byArray, i, Math.min(byArray.length - i, 256));
            if (n < 0) {
                throw new EOFException();
            }
            this.b(50 + (this.a + 5) % 50);
        }
        this.a(n3, n2, by, byArray);
    }

    public synchronized void b(int n) {
        this.a = n;
        this.notify();
    }

    public static int b() {
        return (int)((System.currentTimeMillis() - 946684800163L) / 1000L);
    }

    public String a(short s) {
        return this.a((short)1, (int)s);
    }

    public long a(int n) {
        return this.a((short)1, n, 0L);
    }

    public void a(short s, int n, int n2, byte[] byArray) {
        try {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            DataOutputStream dataOutputStream = new DataOutputStream(byteArrayOutputStream);
            dataOutputStream.writeInt(b.b());
            dataOutputStream.writeShort(s);
            dataOutputStream.writeInt(n);
            dataOutputStream.writeInt(n2);
            if (null != byArray) {
                ((OutputStream)dataOutputStream).write(byArray);
            }
            this.a(2, 0, (byte)0, byteArrayOutputStream.toByteArray());
        }
        catch (Exception exception) {
            // empty catch block
        }
    }

    public void a(Throwable throwable) {
        this.a((short)10, -1, -1, throwable.toString().getBytes());
    }

    public String b(short s) {
        return this.a(s, (Object[])null);
    }

    public String a(short s, Object[] objectArray) {
        try {
            String string = this.a((short)0, (int)s);
            if (null == string || null == objectArray) {
                return string;
            }
            char[] cArray = string.toCharArray();
            StringBuffer stringBuffer = new StringBuffer();
            for (int i = 0; i < cArray.length; ++i) {
                char c = cArray[i];
                if (c < objectArray.length) {
                    stringBuffer.append(objectArray[c]);
                    continue;
                }
                stringBuffer.append(c);
            }
            return stringBuffer.toString();
        }
        catch (Exception exception) {
            this.a(exception);
            return "";
        }
    }

    public static final String a(byte[] byArray) {
        StringBuffer stringBuffer = new StringBuffer();
        int n = 0;
        while (n < byArray.length) {
            int n2 = byArray[n++] & 0xFF;
            int n3 = 0;
            while ((n2 & 0x80) != 0) {
                ++n3;
                n2 <<= 1;
            }
            n2 = (n2 & 0xFF) >> n3;
            for (int i = 1; i < n3 && n < byArray.length; ++i) {
                n2 <<= 6;
                n2 |= byArray[n++] & 0x3F;
            }
            stringBuffer.append((char)n2);
        }
        return stringBuffer.toString();
    }

    public static final byte[] a(String string) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        char[] cArray = string.toCharArray();
        for (int i = 0; i < cArray.length; ++i) {
            int n = cArray[i] & 0xFFFF;
            int n2 = n < 128 ? 0 : (n < 2048 ? 11 : (n < 65536 ? 16 : 21));
            if (n2 > 0) {
                int n3 = n2 % 6;
                n = b.a(byteArrayOutputStream, n << 32 - n2, n3);
                n2 -= n3;
                while (n2 > 0) {
                    n = b.a(byteArrayOutputStream, n, 6);
                    n2 -= 6;
                }
                continue;
            }
            byteArrayOutputStream.write(n);
        }
        return byteArrayOutputStream.toByteArray();
    }

    private static final int a(ByteArrayOutputStream byteArrayOutputStream, int n, int n2) {
        int n3 = 254;
        while (n2-- > 0) {
            n3 = n3 << 1 | n >>> 31;
            n <<= 1;
        }
        byteArrayOutputStream.write(n3 & 0xFF);
        return n;
    }
}
