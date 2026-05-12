package com.thoughtsofnomads.model;

public class UserProfile {
    private int    profileId;
    private int    userId;
    private String fullName;
    private String contactNumber;
    private String bio;
    private String profilePicture;

    public UserProfile() {}

    public int    getProfileId()    { return profileId; }
    public void   setProfileId(int profileId) { this.profileId = profileId; }

    public int    getUserId()       { return userId; }
    public void   setUserId(int userId) { this.userId = userId; }

    public String getFullName()     { return fullName; }
    public void   setFullName(String fullName) { this.fullName = fullName; }

    public String getContactNumber() { return contactNumber; }
    public void   setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getBio()          { return bio; }
    public void   setBio(String bio) { this.bio = bio; }

    public String getProfilePicture() { return profilePicture; }
    public void   setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }

    // used as avatar fallback when no profile picture is uploaded
    public String getInitials() {
        if (fullName == null || fullName.isBlank()) return "?";
        String[] parts = fullName.trim().split("\\s+");
        char first = Character.toUpperCase(parts[0].charAt(0));
        if (parts.length == 1) return String.valueOf(first);
        return "" + first + Character.toUpperCase(parts[parts.length - 1].charAt(0));
    }
}
