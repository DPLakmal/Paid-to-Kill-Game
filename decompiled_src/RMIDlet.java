/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.midlet.MIDlet
 *  javax.microedition.midlet.MIDletStateChangeException
 */
import a.f;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;

public class RMIDlet
extends MIDlet {
    public void startApp() throws MIDletStateChangeException {
        if (h.a == null) {
            h.a = this;
            h.a(1);
            return;
        }
        h.a(3);
    }

    public final void pauseApp() {
        h.a(2);
        this.notifyPaused();
    }

    public final void destroyApp(boolean bl) throws MIDletStateChangeException {
        h.a();
        f.b(4);
    }

    public void b() {
        f.a.d();
    }

    public RMIDlet() {
        f.a = this;
    }
}
