package com.thoughtsofnomads.config;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.List;
import java.util.Properties;

public class EmailService {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String MAIL_USER = "ejlaas@ejlaas.com";
    private static final String MAIL_PASS = "wpgj mdyp riec ghpj";
    private static final String MAIL_ALIAS = "nomads@ejlaas.com";

    public static boolean sendArticlePublished(String recipientEmail, String authorName, String articleTitle) {
        String subject = "Your article has been published — Thoughts of Nomads";
        String body = "Hi " + authorName + ",\n\n"
                + "Great news! Your article \"" + articleTitle + "\" has been reviewed and published on Thoughts of Nomads.\n\n"
                + "It is now live on the site. Thank you for your contribution!\n\n"
                + "— The Thoughts of Nomads Team";
        return sendPlain(recipientEmail, subject, body);
    }

    public static boolean sendArticleRejected(String recipientEmail, String authorName, String articleTitle, String reviewNote) {
        String subject = "Action required: Your article needs revision — Thoughts of Nomads";
        String body = "Hi " + authorName + ",\n\n"
                + "Thank you for submitting \"" + articleTitle + "\". After review, our editorial team has requested some changes before it can be published.\n\n"
                + "Reviewer feedback:\n"
                + "--------------------\n"
                + reviewNote + "\n"
                + "--------------------\n\n"
                + "Please log in to your dashboard, address the feedback, and resubmit your article.\n\n"
                + "— The Thoughts of Nomads Team";
        return sendPlain(recipientEmail, subject, body);
    }

    // ── Newsletter ────────────────────────────────────────────────────────────

    public static int sendNewsletterToAll(List<String> emails, String articleTitle,
                                           String articleUrl, String authorName, String category) {
        int sent = 0;
        for (String email : emails) {
            if (sendNewsletterArticle(email, articleTitle, articleUrl, authorName, category)) sent++;
        }
        return sent;
    }

    private static boolean sendNewsletterArticle(String recipientEmail, String articleTitle,
                                                  String articleUrl, String authorName, String category) {
        String subject = "New Story: " + articleTitle + " — Thoughts of Nomads";
        String html = "<html><body style='margin:0;padding:0;background:#f8f9fa;font-family:Arial,sans-serif;'>"
            + "<table width='100%' cellpadding='0' cellspacing='0' style='background:#f8f9fa;padding:40px 0;'><tr><td align='center'>"
            + "<table width='600' cellpadding='0' cellspacing='0' style='background:#ffffff;border-radius:8px;overflow:hidden;'>"
            + "<tr><td style='background:#0e193e;padding:24px 36px;'>"
            + "<span style='font-family:Georgia,serif;font-size:20px;color:#ffffff;font-weight:bold;'>Thoughts of Nomads</span>"
            + "</td></tr>"
            + "<tr><td style='padding:36px;'>"
            + (category != null ? "<div style='font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.1em;color:#a26b1c;margin-bottom:14px;'>" + category + "</div>" : "")
            + "<h1 style='font-family:Georgia,serif;font-size:26px;color:#0e193e;line-height:1.3;margin:0 0 12px;'>" + articleTitle + "</h1>"
            + (authorName != null ? "<p style='font-size:14px;color:#45464e;margin:0 0 28px;'>By " + authorName + "</p>" : "<p style='margin:0 0 28px;'></p>")
            + "<a href='" + articleUrl + "' style='display:inline-block;background:#0e193e;color:#ffffff;padding:14px 28px;border-radius:4px;text-decoration:none;font-size:14px;font-weight:600;'>Read the Story &rarr;</a>"
            + "</td></tr>"
            + "<tr><td style='padding:20px 36px;border-top:1px solid #e1e3e4;'>"
            + "<p style='font-size:12px;color:#9b9ea4;margin:0;'>You're receiving this because you subscribed to Thoughts of Nomads.</p>"
            + "</td></tr>"
            + "</table></td></tr></table></body></html>";
        return sendHtml(recipientEmail, subject, html);
    }

    private static boolean sendHtml(String recipientEmail, String subject, String html) {
        Session session = buildSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(MAIL_ALIAS, "Thoughts of Nomads"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setContent(html, "text/html;charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private static boolean sendPlain(String recipientEmail, String subject, String body) {
        Session session = buildSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(MAIL_ALIAS, "Thoughts of Nomads"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private static Session buildSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MAIL_USER, MAIL_PASS);
            }
        });
    }

    public static boolean sendPasswordResetOtp(String recipientEmail, String otp) {
        String subject = "Password Reset Code — Thoughts of Nomads";
        String html = "<html><body style='margin:0;padding:0;background:#f8f9fa;font-family:Arial,sans-serif;'>"
            + "<table width='100%' cellpadding='0' cellspacing='0' style='background:#f8f9fa;padding:40px 0;'><tr><td align='center'>"
            + "<table width='480' cellpadding='0' cellspacing='0' style='background:#ffffff;border-radius:8px;overflow:hidden;'>"
            + "<tr><td style='background:#0e193e;padding:22px 32px;'>"
            + "<span style='font-family:Georgia,serif;font-size:18px;color:#ffffff;font-weight:bold;'>Thoughts of Nomads</span>"
            + "</td></tr>"
            + "<tr><td style='padding:36px 32px;text-align:center;'>"
            + "<p style='font-size:14px;color:#45464e;margin:0 0 24px;'>You requested a password reset. Use the code below — it expires in 10 minutes.</p>"
            + "<div style='display:inline-block;background:#f3f4f5;border-radius:8px;padding:20px 40px;margin-bottom:24px;'>"
            + "<span style='font-family:monospace;font-size:36px;font-weight:700;letter-spacing:0.2em;color:#0e193e;'>" + otp + "</span>"
            + "</div>"
            + "<p style='font-size:13px;color:#9b9ea4;margin:0;'>If you didn't request this, you can safely ignore this email.</p>"
            + "</td></tr>"
            + "</table></td></tr></table></body></html>";
        return sendHtml(recipientEmail, subject, html);
    }

    public static boolean sendContactConfirmation(String senderName, String senderEmail,
                                                   String subject, String messageBody) {
        String confirmSubject = "Thank you for reaching out — Thoughts of Nomads";
        String html = "<html><body style='margin:0;padding:0;background:#f8f9fa;font-family:Arial,sans-serif;'>"
            + "<table width='100%' cellpadding='0' cellspacing='0' style='background:#f8f9fa;padding:40px 0;'><tr><td align='center'>"
            + "<table width='560' cellpadding='0' cellspacing='0' style='background:#ffffff;border-radius:8px;overflow:hidden;'>"
            + "<tr><td style='background:#0e193e;padding:24px 36px;'>"
            + "<span style='font-family:Georgia,serif;font-size:20px;color:#ffffff;font-weight:bold;'>Thoughts of Nomads</span>"
            + "</td></tr>"
            + "<tr><td style='padding:36px;'>"
            + "<h2 style='font-family:Georgia,serif;font-size:22px;color:#0e193e;margin:0 0 16px;'>Thank you for reaching out, " + senderName + "!</h2>"
            + "<p style='font-size:15px;color:#45464e;line-height:1.6;margin:0 0 24px;'>We've received your message and our team will get back to you within <strong>24 hours</strong>.</p>"
            + "<div style='background:#f3f4f5;border-left:4px solid #0e193e;border-radius:4px;padding:20px 24px;margin-bottom:24px;'>"
            + "<p style='font-size:12px;font-weight:700;text-transform:uppercase;letter-spacing:0.08em;color:#45464e;margin:0 0 8px;'>Your message</p>"
            + (subject != null && !subject.isBlank() ? "<p style='font-size:14px;font-weight:600;color:#0e193e;margin:0 0 10px;'>" + subject + "</p>" : "")
            + "<p style='font-size:14px;color:#45464e;line-height:1.6;margin:0;white-space:pre-wrap;'>" + messageBody + "</p>"
            + "</div>"
            + "<p style='font-size:14px;color:#45464e;line-height:1.6;margin:0;'>In the meantime, feel free to explore our latest stories at <a href='https://thoughtsofnomads.com' style='color:#0e193e;'>thoughtsofnomads.com</a>.</p>"
            + "</td></tr>"
            + "<tr><td style='padding:20px 36px;border-top:1px solid #e1e3e4;'>"
            + "<p style='font-size:12px;color:#9b9ea4;margin:0;'>— The Thoughts of Nomads Team</p>"
            + "</td></tr>"
            + "</table></td></tr></table></body></html>";
        return sendHtml(senderEmail, confirmSubject, html);
    }

    public static boolean sendContactMessage(String senderName, String senderEmail,
                                              String subject, String messageBody) {
        String fullSubject = (subject != null && !subject.isBlank())
                ? "Contact: " + subject + " — Thoughts of Nomads"
                : "New Contact Message — Thoughts of Nomads";
        String body = "You have a new contact form submission.\n\n"
                + "From:    " + senderName + "\n"
                + "Email:   " + senderEmail + "\n"
                + "Subject: " + (subject != null ? subject : "(none)") + "\n\n"
                + "Message:\n"
                + "--------------------\n"
                + messageBody + "\n"
                + "--------------------\n\n"
                + "Reply directly to " + senderEmail + " to respond.";
        return sendPlain(MAIL_USER, fullSubject, body);
    }

    public static boolean sendOTP(String recipientEmail, String otp) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MAIL_USER, MAIL_PASS);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(MAIL_ALIAS, "Thoughts of Nomads"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Your Thoughts of Nomads Verification Code");
            message.setText("Welcome to Thoughts of Nomads!\n\nYour verification code is: " + otp + "\n\nPlease enter this code to activate your account.");

            Transport.send(message);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
