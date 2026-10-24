/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Graphics
 *  javax.microedition.lcdui.Image
 */
import java.io.DataInputStream;
import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public final class b {
    private static Object[] a;
    private static Object[] b;
    private static short[][] a;
    private static short[][] b;
    private static short[][] c;
    private static int a;
    private static int[] a;
    private static int b;
    private static int c;

    private b() {
    }

    public static final void a() {
        b = new Object[11];
        a = new short[299][];
    }

    private static synchronized Object[] a() {
        if (a != null) {
            return a;
        }
        Object[] objectArray = new Object[3];
        String[] stringArray = new String[11];
        int[] nArray = new int[11];
        int[] nArray2 = new int[11];
        try {
            DataInputStream dataInputStream = new DataInputStream(h.a.getClass().getResourceAsStream("/h"));
            for (int i = 0; i < 11; ++i) {
                nArray[i] = dataInputStream.readInt();
                stringArray[i] = dataInputStream.readUTF();
                nArray2[i] = dataInputStream.readInt();
            }
            dataInputStream.close();
        }
        catch (IOException iOException) {}
        objectArray[0] = nArray;
        objectArray[1] = stringArray;
        objectArray[2] = nArray2;
        a = objectArray;
        return objectArray;
    }

    public static final synchronized short[] a(int n2) {
        if (c == null) {
            c = new short[6][];
            b.c[5] = new short[1];
            b = new short[0][];
            try {
                InputStream inputStream = h.a.getClass().getResourceAsStream("/g");
                if (inputStream != null) {
                    DataInputStream dataInputStream = new DataInputStream(inputStream);
                    int n3 = 0;
                    for (n3 = 0; n3 < 5; ++n3) {
                        short[] sArray = new short[dataInputStream.readShort()];
                        for (int i = 0; i < sArray.length; ++i) {
                            sArray[i] = dataInputStream.readShort();
                        }
                        b.c[n3] = sArray;
                    }
                    dataInputStream.close();
                }
            }
            catch (IOException iOException) {}
        }
        return c[n2];
    }

    public static final void a(int n2) {
        a = n2;
    }

    private static void a(DataInputStream dataInputStream, int n2) throws IOException {
        int n3 = 0;
        while (n3 < n2) {
            n3 = dataInputStream.skipBytes(n2 - n3);
        }
    }

    private static byte[] a(DataInputStream dataInputStream, byte[] byArray, int n2) throws IOException {
        int n3 = 0;
        while (n3 < n2) {
            n3 = dataInputStream.read(byArray, n3, n2 - n3);
        }
        return byArray;
    }

    public static final synchronized Object a(int n2) {
        b.a((int)5)[0] = (short)n2;
        return b.a(5);
    }

    public static final synchronized Object[] a(int n2) {
        Object[] objectArray = b.a();
        String[] stringArray = (String[])objectArray[1];
        int[] nArray = (int[])objectArray[0];
        int[] nArray2 = (int[])objectArray[2];
        short[] sArray = b.a(n2);
        Object[] objectArray2 = new Object[sArray.length];
        String[] stringArray2 = new String[sArray.length];
        try {
            int n3;
            int n4 = 0;
            String string = "";
            FilterInputStream filterInputStream = null;
            for (n3 = 0; n3 < sArray.length; ++n3) {
                short s = sArray[n3];
                if (s < 0 || s > 11) continue;
                if (b[s] != null && s != 0) {
                    objectArray2[n3] = b[s];
                    continue;
                }
                if (!stringArray[s].equals(string)) {
                    if (filterInputStream != null) {
                        filterInputStream.close();
                    }
                    filterInputStream = new DataInputStream(h.a.getClass().getResourceAsStream("/" + stringArray[s]));
                    n4 = 0;
                }
                int n5 = nArray[s] - n4;
                b.a((DataInputStream)filterInputStream, n5);
                n4 += n5;
                stringArray2[n3] = b.a((DataInputStream)filterInputStream, s, nArray2[s]);
                if (stringArray2[n3] == null) {
                    objectArray2[n3] = b[s];
                }
                n4 += nArray2[s];
                string = stringArray[s];
            }
            if (filterInputStream != null) {
                filterInputStream.close();
            }
            for (n3 = 0; n3 < stringArray2.length; ++n3) {
                if (stringArray2[n3] == null) continue;
                objectArray2[n3] = Image.createImage((String)("/" + stringArray2[n3]));
                b.b[sArray[n3]] = objectArray2[n3];
            }
        }
        catch (IOException iOException) {}
        return objectArray2;
    }

    private static String a(DataInputStream dataInputStream, int n2, int n3) throws IOException {
        if (n2 < 1) {
            String[] stringArray = new String[7];
            int[] nArray = new int[7];
            for (int i = 0; i < 7; ++i) {
                stringArray[i] = dataInputStream.readUTF();
                nArray[i] = dataInputStream.readInt();
            }
            b.a(dataInputStream, nArray[a]);
            if (b[0] == null) {
                b.b[0] = new String[205];
            }
            String[] stringArray2 = (String[])b[0];
            for (int i = 0; i < 205; ++i) {
                if (b == -1 || i >= b && i <= c) {
                    stringArray2[i] = dataInputStream.readUTF();
                } else {
                    dataInputStream.readUTF();
                }
                if (c != -1 && i > c) break;
            }
            b = -1;
            c = -1;
        } else if (n2 < 9) {
            int n4;
            Object object;
            int n5 = 0;
            int n6 = dataInputStream.readShort();
            short s = dataInputStream.readShort();
            n5 = 0 + ((s - n6) * 12 + 4);
            for (int i = n6; i < s; ++i) {
                object = new short[7];
                for (n4 = 0; n4 < 6; ++n4) {
                    object[n4] = dataInputStream.readShort();
                }
                object[6] = (short)n2;
                b.a[i] = (short[])object;
            }
            byte[] byArray = new byte[8];
            object = "";
            for (n4 = 0; n4 < 8; ++n4) {
                byArray[n4] = dataInputStream.readByte();
                if (byArray[n4] == 0) continue;
                object = (String)object + (char)byArray[n4];
            }
            n5 += 8;
            if (!((String)object).equals("")) {
                b.a(dataInputStream, n3 - n5);
                return object;
            }
            byte[] byArray2 = new byte[n3 - n5];
            byArray2 = b.a(dataInputStream, byArray2, byArray2.length);
            b.b[n2] = Image.createImage((byte[])byArray2, (int)0, (int)byArray2.length);
        } else {
            byte[] byArray = new byte[n3];
            byArray = b.a(dataInputStream, byArray, n3);
            b.b[n2] = byArray;
        }
        return null;
    }

    public static final synchronized void b(int n2) {
        b.a((int)5)[0] = (short)n2;
        b.c(5);
    }

    public static final synchronized void c(int n2) {
        short[] sArray = b.a(n2);
        for (int i = 0; i < sArray.length; ++i) {
            short s = sArray[i];
            if (s < 9 && s > 0) {
                for (int i2 = 0; i2 < a.length; ++i2) {
                    short[] sArray2 = a[i2];
                    if (sArray2 == null || sArray2[6] != s) continue;
                    b.a[i2] = null;
                }
                b.b[s] = null;
                continue;
            }
            b.b[s] = null;
        }
        System.gc();
    }

    public static final Object b(int n2) {
        return b[n2];
    }

    public static final String a(int n2) {
        return ((String[])b.b(0))[n2];
    }

    public static final String a(int n2, String[] stringArray) {
        int n3;
        Object object = b.a(n2);
        String string = "";
        int n4 = 0;
        while (true) {
            n3 = n4;
            if ((n4 = ((String)object).indexOf(37, n4)) == -1) break;
            string = string + ((String)object).substring(n3, n4);
            string = string + stringArray[((String)object).charAt(n4 + 1) - 49];
            n4 += 2;
        }
        string = string + ((String)object).substring(n3, ((String)object).length());
        return string;
    }

    public static final synchronized String[] a() {
        String[] stringArray = new String[7];
        Object[] objectArray = b.a();
        String string = ((String[])objectArray[1])[0];
        int n2 = ((int[])objectArray[0])[0];
        try {
            DataInputStream dataInputStream = new DataInputStream(h.a.getClass().getResourceAsStream("/" + string));
            b.a(dataInputStream, n2);
            for (int i = 0; i < 7; ++i) {
                stringArray[i] = dataInputStream.readUTF();
                dataInputStream.readInt();
            }
            dataInputStream.close();
        }
        catch (IOException iOException) {}
        return stringArray;
    }

    public static final int a(int n2, int n3) {
        return a[n2][n3];
    }

    public static final void a(int n2, int n3, int n4, Graphics graphics) {
        short[] sArray = a[n4];
        Image image = (Image)b.b(sArray[6]);
        if (h.a(graphics, n2 - sArray[4], n3 - sArray[5], sArray[2], sArray[3], a)) {
            graphics.drawImage(image, n2 - sArray[4] - sArray[0], n3 - sArray[5] - sArray[1], 20);
            graphics.setClip(a[0], a[1], a[2], a[3]);
        }
    }

    static {
        a = 0;
        a = new int[4];
        b = -1;
        c = -1;
    }
}
