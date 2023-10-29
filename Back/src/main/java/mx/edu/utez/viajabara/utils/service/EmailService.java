package mx.edu.utez.viajabara.utils.service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.UUID;

@Service
public class EmailService {
    private final static Logger LOGGER = LoggerFactory.getLogger(EmailService.class);

    @Autowired
    private JavaMailSender emailSender;

    String generateContentId(String prefix) {
        return String.format("%s-%s", prefix, UUID.randomUUID());
    }

    @Value("${spring.mail.username}")
    private String email;


    @Value("${spring.mail.password}")
    private String pass;

    public void sendSimpleMessage(String to, String subject, String text) {
        try {
            MimeMessage mimeMessage = emailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");
            String htlmMsg = "<h3 style='color:rgb(0,46,93);'>ViajaBara</h3><br>" +
                    text + "<br><hr style='border-color:rgb(0,171,132);'/><p style='text-align:justify;'>Si no solicitaste este cambio, ignora el correo.</p>" +
                    "<p style='text-align:justify;'>Esta cuenta de correo no es supervisada, no responder este mensaje.</p>";
            helper.setFrom("noreply@baeldung.com");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htlmMsg, true);
            emailSender.send(mimeMessage);
        } catch (Exception e) {
        }
    }

    public static byte[] getQRCodeImage(String text, int width, int height) throws WriterException, IOException {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

        ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
        MatrixToImageConfig con = new MatrixToImageConfig(0xFF7E1431, 0xFFF5F5F5);

        MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream, con);
        return pngOutputStream.toByteArray();
    }

}
