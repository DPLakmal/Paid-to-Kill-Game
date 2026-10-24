/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Command
 *  javax.microedition.lcdui.CommandListener
 *  javax.microedition.lcdui.Displayable
 *  javax.microedition.lcdui.Form
 */
package a;

import a.f;
import java.util.Vector;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public class a
implements CommandListener {
    public static String[] a = new String[0];
    private static boolean a;
    private static final Command a;
    private static final a a;
    private long a;
    private Form a = System.currentTimeMillis();

    public static void a(Object object, String string) {
        a.b(object, string);
    }

    private synchronized void b(Object object, String string) {
    }

    public synchronized void commandAction(Command command, Displayable displayable) {
        this.a = null;
        f.c();
    }

    static {
        String string = System.getProperty("greystripe.trace_classes");
        if (string != null) {
            Vector<String> vector = new Vector<String>();
            int n = string.indexOf(",");
            while (n >= 0 || string.length() > 0) {
                if (n >= 0) {
                    String string2 = string.substring(0, n).trim();
                    vector.addElement(string2);
                    string = string.substring(n + 1);
                    continue;
                }
                vector.addElement(string);
                string = "";
            }
            a = new String[vector.size()];
            vector.copyInto(a);
        }
        if ((string = System.getProperty("device.model")) != null) {
            a = string.indexOf("emulator") >= 0;
        }
        a = new Command("Ok", 4, 1);
        a = new a();
    }
}
