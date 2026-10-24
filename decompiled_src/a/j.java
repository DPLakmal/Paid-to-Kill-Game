/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.Canvas
 *  javax.microedition.lcdui.Command
 *  javax.microedition.lcdui.CommandListener
 *  javax.microedition.lcdui.Displayable
 *  javax.microedition.lcdui.Font
 *  javax.microedition.lcdui.Graphics
 *  javax.microedition.lcdui.Image
 */
package a;

import a.f;
import a.h;
import a.k;
import java.util.Hashtable;
import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Font;
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public class j
extends Canvas
implements Runnable,
CommandListener {
    private static boolean a = false;
    private byte a;
    private int a;
    private boolean b;
    private int b;
    private boolean c;
    private int c;
    private k a;
    private Image a;
    private Hashtable a;
    private Command a = new Command("Menu", 4, 1);
    private Command b;
    private byte b = new Command("Select", 4, 1);
    private int d = -1;

    public static int a() {
        j j2 = new j();
        f.a(j2);
        return j2.getHeight();
    }

    public static int b() {
        return new j().getWidth();
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public static void a(int n, int n2, boolean bl) {
        if (bl) {
            if (a) {
                return;
            }
            a = true;
        }
        j j2 = new j(n, n2, bl);
        if (!bl) {
            j2.run();
            while (j2.a != 3) {
                try {
                    j j3 = j2;
                    synchronized (j3) {
                        j2.wait();
                    }
                }
                catch (Exception exception) {
                }
            }
        } else {
            j.a(j2);
        }
    }

    private static void a(j j2) {
        new Thread(j2).start();
    }

    private j() {
    }

    public j(int n, int n2, boolean bl) {
        this.a = n;
        this.b = n2;
        this.c = bl;
        this.setCommandListener(this);
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public void run() {
        h h2 = f.a;
        if (this.a == 0 || this.a == 1) {
            this.b = f.a(this);
            int n = j.a();
            this.a = null;
            this.a = null;
            while (null == this.a && this.b > 0) {
                this.a = h2.a(this.a);
                --this.b;
                if (this.a == null) continue;
                this.a = Image.createImage((byte[])this.a.a, (int)this.a.c, (int)this.a.d);
            }
            if (this.a != null && this.a.a != this.c) {
                if (this.a == 0) {
                    this.c = this.a.a;
                }
                this.b = (byte)this.a.a.length;
                if (!this.b) {
                    this.addCommand(this.a);
                }
                if (this.a == 0) {
                    f.a((Displayable)this);
                }
                this.repaint();
                h2.a(this.a);
            } else {
                if (this.c) {
                    f.a.notifyDestroyed();
                    return;
                }
                if (this.a == 1) {
                    f.c();
                }
                this.a = (byte)3;
                j j2 = this;
                synchronized (j2) {
                    this.notify();
                }
            }
        }
    }

    public void paint(Graphics graphics) {
        if (this.a == null) {
            return;
        }
        int n = this.getWidth();
        int n2 = this.getHeight();
        graphics.setGrayScale(0);
        graphics.fillRect(0, 0, n, n2);
        graphics.drawImage(this.a, n / 2, n2 / 2, 3);
        if (this.d > -1) {
            Font font = Font.getFont((int)32, (int)0, (int)8);
            int n3 = font.getHeight() + 3;
            int n4 = (this.b + 1) * n3 + 1;
            int n5 = n2 - n4 - 1;
            int[] nArray = this.a.a;
            graphics.setColor(0xFFFFFF);
            graphics.fillRect(0, n5, n, n4);
            graphics.setColor(9086719);
            graphics.drawLine(0, n5, n, n5);
            ++n5;
            int n6 = this.a.a.length;
            for (int i2 = 0; i2 <= this.b; ++i2) {
                String string = i2 < n6 ? f.a.a(nArray[i2]) : "Continue";
                graphics.setColor(i2 == this.d ? 2117277 : 0xFFFFFF);
                graphics.fillRect(0, n5, n, n3);
                graphics.setColor(i2 == this.d ? 0xFFFFFF : 9086719);
                graphics.drawString(String.valueOf(i2 + 1), 4, n5 += n3, 36);
                graphics.drawString(string, 4 + n3, n5, 36);
            }
        }
    }

    public void commandAction(Command command, Displayable displayable) {
        this.keyPressed(-5);
    }

    public void keyPressed(int n) {
        int n2;
        int n3 = -2;
        for (n2 = 48; n2 <= 57; ++n2) {
            if (n != n2) continue;
            n3 = n2 - 49;
        }
        if (n3 == -1) {
            n3 = 9;
        }
        if (n3 < 0) {
            if (n == this.getKeyCode(1) || n == this.getKeyCode(2)) {
                n3 = -3;
            } else if (n == this.getKeyCode(6) || n == this.getKeyCode(5)) {
                n3 = -4;
            } else if (n == this.getKeyCode(8) || n == -5) {
                n3 = -5;
            } else if (n == -1 || n == -3) {
                n3 = -3;
            } else if (n == -2 || n == -4) {
                n3 = -4;
            }
        }
        if (this.d == -1) {
            this.d = 0;
            if (!this.b) {
                this.removeCommand(this.a);
                this.addCommand(this.b);
            }
        } else {
            if (n3 >= 0 && n3 <= this.b) {
                this.d = n3;
                n3 = -5;
            }
            if (n3 == -3) {
                if (this.d > 0) {
                    --this.d;
                }
            } else if (n3 == -4) {
                if (this.d < this.b) {
                    ++this.d;
                }
            } else if (n3 == -5) {
                if (!this.b) {
                    this.removeCommand(this.b);
                    this.addCommand(this.a);
                }
                if (this.d == this.b) {
                    this.a = 1;
                    j.a(this);
                } else if (this.d < this.a.a.length && this.d >= 0) {
                    n2 = this.a.a[this.d];
                    this.d = -1;
                    f.a.a(this.a, this.a, n2);
                }
                this.d = -1;
            }
        }
        this.repaint();
    }
}
