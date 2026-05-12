package com.thoughtsofnomads.model;

public enum AccountStatus {
    ACTIVE,
    LOCKED,    // temporary lockout after too many failed login attempts
    DISABLED,  // manually disabled by admin
    PENDING    // email not yet verified after registration
}
