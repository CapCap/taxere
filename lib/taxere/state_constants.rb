module Taxere
  class StateConstants < BasicObject
    STATE_FULL_NAMES = ["Alabama", "Alaska", "Arizona", "Arkansas",
                        "California", "Colorado", "Connecticut", "Delaware",
                        "District of Columbia", "Florida", "Georgia", "Hawaii",
                        "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
                        "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan",
                        "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska",
                        "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York",
                        "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
                        "Pennsylvania", "Rhode Island", "South Carolina",
                        "South Dakota", "Tennessee", "Texas", "Utah",
                        "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"].freeze

    STATE_SHORT_NAMES = ["AL", "AK", "AZ", "AR",
                         "CA", "CO", "CT", "DE",
                         "DC", "FL", "GA", "HI",
                         "ID", "IL", "IN", "IA", "KS", "KY",
                         "LA", "ME", "MD", "MA", "MI",
                         "MN", "MS", "MO", "MT", "NE",
                         "NV", "NH", "NJ", "NM", "NY",
                         "NC", "ND", "OH", "OK", "OR",
                         "PA", "RI", "SC",
                         "SD", "TN", "TX", "UT",
                         "VT", "VA", "WA", "WV", "WI", "WY"].freeze

    SHORT_TO_FULL_MAP = STATE_SHORT_NAMES.zip(STATE_FULL_NAMES).to_h.freeze

  end
end


