Time::DATE_FORMATS[:w3c] = lambda {|time| time.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00") }
