/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.lcdui.ChoiceGroup
 *  javax.microedition.lcdui.Command
 *  javax.microedition.lcdui.CommandListener
 *  javax.microedition.lcdui.Displayable
 *  javax.microedition.lcdui.Form
 *  javax.microedition.lcdui.Image
 *  javax.microedition.lcdui.ImageItem
 *  javax.microedition.lcdui.Item
 *  javax.microedition.lcdui.TextField
 */
package a;

import a.a;
import a.d;
import a.f;
import a.i;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Hashtable;
import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Image;
import javax.microedition.lcdui.ImageItem;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.TextField;

/*
 * Duplicate member names - consider using --renamedupmembers true
 */
public class e
implements i,
CommandListener {
    private static Command a = new Command("Cancel", 3, 2);
    private Hashtable a;
    private int a;
    private int b;
    private Form a = new Hashtable();
    private Hashtable b = new Hashtable();
    private Hashtable c = new Hashtable();

    public static void a(int n) {
        f.a(n, new e());
    }

    private e() {
    }

    public String a(byte[] byArray, int n, int n2) {
        try {
            return f.a(byArray, n, n2).readUTF();
        }
        catch (IOException iOException) {
            return "Info";
        }
    }

    public void a(int n, int n2, int n3, byte[] byArray, int n4, int n5) {
        a.a.a(this, "JumpPage for " + n + "," + n2 + "," + n3);
        this.c.clear();
        this.a.clear();
        this.b.clear();
        this.a = n2;
        this.b = n3;
        try {
            this.a = new Form(null);
            DataInputStream dataInputStream = f.a(byArray, n4, n5);
            dataInputStream.readUTF();
            dataInputStream.readShort();
            int n6 = dataInputStream.readByte();
            byte by = 0;
            for (int j = 0; j < n6; ++j) {
                String string;
                by = dataInputStream.readByte();
                if (by == 2) {
                    this.a.append(dataInputStream.readUTF());
                    continue;
                }
                if (by == 1) {
                    byte by2 = dataInputStream.readByte();
                    short s = dataInputStream.readShort();
                    byte[] byArray2 = new byte[s];
                    dataInputStream.readFully(byArray2, 0, s);
                    ImageItem imageItem = new ImageItem(null, Image.createImage((byte[])byArray2, (int)0, (int)s), by2 == 3 ? 2 : (by2 == 2 ? 3 : 1), null);
                    this.a.append((Item)imageItem);
                    continue;
                }
                String string2 = dataInputStream.readUTF();
                if (by == 7) {
                    byte by3 = dataInputStream.readByte();
                    boolean bl = (by3 & 1) == 1;
                    boolean bl2 = (by3 & 2) == 2;
                    String string3 = bl ? dataInputStream.readUTF() : null;
                    string = bl2 ? dataInputStream.readUTF() : null;
                    byte by4 = dataInputStream.readByte();
                    byte by5 = dataInputStream.readByte();
                    TextField textField = new TextField(string3, string, (int)by5, (int)by4);
                    this.b.put(string2, textField);
                    this.a.append((Item)textField);
                    continue;
                }
                if (by == 3) {
                    TextField textField = new TextField(null, null, 32, 0);
                    this.b.put(string2, textField);
                    this.a.append((Item)textField);
                    continue;
                }
                if (by == 4) {
                    ChoiceGroup choiceGroup = new ChoiceGroup(null, 2);
                    this.b.put(string2, choiceGroup);
                    String string4 = dataInputStream.readUTF();
                    boolean bl = dataInputStream.readBoolean();
                    choiceGroup.append(string4, null);
                    choiceGroup.setSelectedIndex(0, bl);
                    this.a.append((Item)choiceGroup);
                    continue;
                }
                if (by == 6) {
                    Command command = new Command(string2, 4, 1);
                    int n7 = dataInputStream.readByte();
                    String[] stringArray = new String[n7];
                    for (int k = 0; k < n7; ++k) {
                        stringArray[k] = dataInputStream.readUTF();
                    }
                    this.a.put(command, stringArray);
                    this.a.addCommand(command);
                    continue;
                }
                ChoiceGroup choiceGroup = new ChoiceGroup(null, 1);
                this.b.put(string2, choiceGroup);
                int n8 = dataInputStream.readByte();
                byte by6 = dataInputStream.readByte();
                for (int k = 0; k < n8; ++k) {
                    string = dataInputStream.readUTF();
                    String string5 = dataInputStream.readUTF();
                    choiceGroup.append(string, null);
                    this.c.put(string2 + k, string5);
                }
                choiceGroup.setSelectedIndex((int)by6, true);
                this.a.append((Item)choiceGroup);
            }
            if (this.a.size() == 0) {
                Command command = new Command("Continue", 4, 1);
                this.a.put(command, new String[]{""});
                this.a.addCommand(command);
            }
            this.a.setCommandListener((CommandListener)this);
            this.a.addCommand(a);
            f.a((Displayable)this.a);
        }
        catch (IOException iOException) {
            // empty catch block
        }
    }

    private Hashtable a() {
        Hashtable<String, String> hashtable = new Hashtable<String, String>(this.b.size());
        Enumeration enumeration = this.b.keys();
        while (enumeration.hasMoreElements()) {
            TextField textField;
            String string = (String)enumeration.nextElement();
            String string2 = null;
            Object v = this.b.get(string);
            if (v instanceof TextField) {
                textField = (TextField)v;
                string2 = textField.getString();
            } else {
                textField = (ChoiceGroup)v;
                int n = textField.getSelectedIndex();
                string2 = n == -1 ? (textField.isSelected(0) ? "T" : "F") : (String)this.c.get(string + n);
            }
            hashtable.put(string, string2);
        }
        return hashtable;
    }

    public void commandAction(Command command, Displayable displayable) {
        byte[] byArray = null;
        String[] stringArray = (String[])this.a.get(command);
        if (null != stringArray) {
            Hashtable hashtable = this.a();
            String string = e.a(stringArray, hashtable);
            try {
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                DataOutputStream dataOutputStream = new DataOutputStream(byteArrayOutputStream);
                dataOutputStream.writeUTF("_action");
                dataOutputStream.writeUTF(command.getLabel());
                Enumeration enumeration = hashtable.keys();
                while (enumeration.hasMoreElements()) {
                    String string2 = (String)enumeration.nextElement();
                    String string3 = (String)hashtable.get(string2);
                    if (string3.length() <= 0) continue;
                    dataOutputStream.writeUTF(string2);
                    dataOutputStream.writeUTF(string3);
                }
                byArray = byteArrayOutputStream.toByteArray();
            }
            catch (IOException iOException) {
                // empty catch block
            }
            f.a.a((short)2, this.a, this.b, byArray);
            f.a.f();
            this.a(string);
        }
        f.c();
    }

    private void a(String string) {
        if (string.startsWith("sms:")) {
            d d2 = new d(string.substring(4));
        } else {
            f.a(string);
        }
    }

    private static final String a(String[] stringArray, Hashtable hashtable) {
        StringBuffer stringBuffer = new StringBuffer();
        for (int j = 0; j < stringArray.length; ++j) {
            String string = stringArray[j];
            if (string.length() <= 0) continue;
            if (string.startsWith("\u0000")) {
                String string2 = (String)hashtable.get(string.substring(1));
                if (null == string2) continue;
                stringBuffer.append(string2);
                continue;
            }
            stringBuffer.append(string);
        }
        return stringBuffer.toString();
    }
}
