package its.me.baby.dto;

import java.util.Date;

import org.springframework.social.facebook.api.Post;
import org.springframework.social.twitter.api.Tweet;

public class StreamEntry implements Comparable<StreamEntry>{

	public static final int TYPE_UNKNOWN = 0;

	public static final int TYPE_FACEBOOK = 1;

	public static final int TYPE_TWITTER = 2;
	
	private Object entry = null;

	public StreamEntry(Object entry) {
		super();
		this.entry = entry;
	}
	
	public Object getEntry() {
		return entry;
	}

	public int getType() {
		if (entry instanceof Post) {
			return TYPE_FACEBOOK;
		} else if (entry instanceof Tweet) {
			return TYPE_TWITTER;
		}
		return TYPE_UNKNOWN;
	}
	
	public boolean getIsFacebook() {
		return (entry instanceof Post);
	}

	public boolean getIsTwitter() {
		return (entry instanceof Tweet);
	}

	public Date getCreatedAt() {
		if (entry instanceof Post) {
			return ((Post)entry).getCreatedTime();
		} else if (entry instanceof Tweet) {
			return ((Tweet)entry).getCreatedAt();
		}
		return null;
	}

	public String getMessage() {
		if (entry instanceof Post) {
			return ((Post)entry).getMessage();
		} else if (entry instanceof Tweet) {
			return ((Tweet)entry).getText();
		}
		return "";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((entry == null) ? 0 : entry.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;

		StreamEntry other = (StreamEntry) obj;
		if (entry == null) {
			if (other.entry != null) return false;
		} else {
			if (other.entry == null) return false;
			if (entry instanceof Post) {
				if (!((Post)entry).getId().equals(((Post)other.entry).getId())) return false;
			} else if (entry instanceof Tweet) {
				if (((Tweet)entry).getId() != ((Tweet)other.entry).getId()) return false;
			}
		}
		return true;
	}

	public int compareTo(StreamEntry o) {
		return this.getCreatedAt().compareTo(o.getCreatedAt());
	}

}
