/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.microedition.io.Connector
 *  javax.microedition.lcdui.Alert
 *  javax.microedition.lcdui.AlertType
 *  javax.microedition.lcdui.Display
 *  javax.microedition.lcdui.Displayable
 *  javax.microedition.midlet.MIDlet
 *  javax.wireless.messaging.Message
 *  javax.wireless.messaging.MessageConnection
 *  javax.wireless.messaging.TextMessage
 */
package a;

import a.f;
import javax.microedition.io.Connector;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.midlet.MIDlet;
import javax.wireless.messaging.Message;
import javax.wireless.messaging.MessageConnection;
import javax.wireless.messaging.TextMessage;

public class d
implements Runnable {
    private String a;
    private String b;

    public d(String string) {
        int n = string.indexOf("/");
        this.a = string.substring(0, n);
        this.b = string.substring(n + 1);
        new Thread(this).start();
    }

    /*
     * WARNING - Removed try catching itself - possible behaviour change.
     */
    public void run() {
        try {
            String string = "sms://" + this.a;
            MessageConnection messageConnection = (MessageConnection)Connector.open((String)string);
            try {
                TextMessage textMessage = (TextMessage)messageConnection.newMessage("text");
                textMessage.setPayloadText(this.b);
                messageConnection.send((Message)textMessage);
            }
            finally {
                messageConnection.close();
            }
        }
        catch (Exception exception) {
            Alert alert = new Alert("Form Failure", "The form submission could not complete due to either a bad SMS telephone number or a problem with the phone or the phone service.", null, AlertType.ERROR);
            alert.setTimeout(-2);
            Display.getDisplay((MIDlet)f.a).setCurrent((Displayable)alert);
        }
    }
}
