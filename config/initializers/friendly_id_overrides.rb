module FriendlyId
  module Slugged
    def normalize_friendly_id(string)
      # Strips apostophes so they don't become dashes
      # So instead of Miss Amy's Daycare becoming miss-amy-s-daycare its miss-amys-daycare
      string.to_s.gsub("\'", "").parameterize
    end
  end
end