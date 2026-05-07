package com.thoughtsofnomads.model;

import java.sql.Timestamp;

public class Subscriber {
    private int       subscriberId;
    private String    email;
    private Timestamp subscribedAt;

    public int       getSubscriberId()              { return subscriberId; }
    public void      setSubscriberId(int id)         { this.subscriberId = id; }

    public String    getEmail()                      { return email; }
    public void      setEmail(String email)          { this.email = email; }

    public Timestamp getSubscribedAt()               { return subscribedAt; }
    public void      setSubscribedAt(Timestamp t)    { this.subscribedAt = t; }
}
