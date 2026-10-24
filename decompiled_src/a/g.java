/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.io.ConnectionNotFoundException
 */
package a;

import a.f;
import a.i;
import java.io.DataInputStream;
import java.io.IOException;
import javax.microedition.io.ConnectionNotFoundException;

public class g
implements i {
    public static void a(int n) {
        f.a(n, new g());
    }

    private g() {
    }

    public String a(byte[] byArray, int n, int n2) {
        try {
            return f.a(byArray, n, n2).readUTF();
        }
        catch (IOException iOException) {
            return "Browse";
        }
    }

    public void a(int n, int n2, int n3, byte[] byArray, int n4, int n5) {
        try {
            DataInputStream dataInputStream = f.a(byArray, n4, n5);
            f.a.a((short)2, n2, n3, null);
            dataInputStream.readUTF();
            f.a(dataInputStream.readUTF());
        }
        catch (ConnectionNotFoundException connectionNotFoundException) {
            f.a("Error opening URL", connectionNotFoundException);
        }
        catch (IOException iOException) {
            // empty catch block
        }
    }
}
