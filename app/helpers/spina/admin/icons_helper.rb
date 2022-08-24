require 'nokogiri'

module Spina::Admin
	module IconsHelper
	
		class FileNotFound < StandardError
	  end
		
		def heroicon(name, style: :outline, **options)
			name = heroicons_naming_v1_to_v2(name)
	    file = read_file(Spina::Engine.root.join("app/assets/icons/heroicons", style.to_s, "#{name}.svg"))
	    return "" if file.nil?
	    doc = Nokogiri::XML(file)
	    svg = doc.root
	    svg[:class] = options[:class]
	    ActiveSupport::SafeBuffer.new(svg.to_s)
		end
		
		private
		
	    def read_file(path)
	      return nil unless File.exist?(path)
	      File.read(path)
	    end
			
			def heroicons_naming_v1_to_v2(name)
				lookup_table = {
					"adjustments" => "adjustments-vertical",
					"annotation" => "chat-bubble-bottom-center-text",
					"archive" => "archive-box",
					"arrow-circle-down" => "arrow-down-circle",
					"arrow-circle-left" => "arrow-left-circle",
					"arrow-circle-right" => "arrow-right-circle",
					"arrow-circle-up" => "arrow-up-circle",
					"arrow-narrow-down" => "arrow-long-down",
					"arrow-narrow-left" => "arrow-long-left",
					"arrow-narrow-right" => "arrow-long-right",
					"arrow-narrow-up" => "arrow-long-up",
					"arrow-sm-left" => nil,
					"arrow-sm-right" => nil,
					"arrow-sm-up" => nil,
					"arrow-sm-down" => nil,
					"arrows-expand" => "arrows-pointing-out",
					"badge-check" => "check-badge",
					"ban" => "no-symbol",
					"bookmark-alt" => "bookmark-square",
					"cash" => "banknotes",
					"chart-square-bar" => "chart-bar-square",
					"chat-alt-2" => "chat-bubble-left-right",
					"chat-alt" => "chat-bubble-left-ellipsis",
					"chat" => "chat-bubble-oval-left-ellipsis",
					"chip" => "cpu-chip",
					"clipboard-check" => "clipboard-document-check",
					"clipboard-copy" => "clipboard-document",
					"clipboard-list" => "clipboard-document-list",
					"cloud-download" => "cloud-arrow-down",
					"cloud-upload" => "cloud-arrow-up",
					"code" => "code-bracket",
					"collection" => "rectangle-stack",
					"color-swatch" => "swatch",
					"cube-transparent" => nil,
					"currency-bangladeshi" => nil,
					"cursor-click" => "cursor-arrow-rays",
					"database" => "circle-stack",
					"desktop-computer" => "computer-desktop",
					"device-mobile" => "device-phone-mobile",
					"document-add" => "document-plus",
					"document-download" => "document-arrow-down",
					"document-remove" => "document-minus",
					"document-report" => "document-chart-bar",
					"document-search" => "document-magnifying-glass",
					"dots-circle-horizontal" => "ellipsis-horizontal-circle",
					"dots-horizontal" => "ellipsis-horizontal",
					"dots-vertical" => "ellipsis-vertical",
					"download" => "arrow-down-tray",
					"duplicate" => "square-2-stack",
					"emoji-happy" => "face-smile",
					"emoji-sad" => "face-frown",
					"exclamation" => "exclamation",
					"external-link" => "arrow-top-right-on-square",
					"eye-off" => "eye-slash",
					"fast-forward" => "forward",
					"filter" => "funnel",
					"folder-add" => "folder-plus",
					"folder-download" => "folder-arrow-down",
					"folder-remove" => "folder-minus",
					"globe" => "globe-europe-africa",
					"hand" => "hand-raised",
					"inbox-in" => "inbox-arrow-down",
					"library" => "building-library",
					"lightning-bolt" => "bolt",
					"location-marker" => "map-pin",
					"login" => "arrow-left-on-rectangle",
					"logout" => "arrow-right-on-rectangle",
					"mail-open" => "envelope-open",
					"mail" => "envelope",
					"menu-alt-1" => "bars-3-center-left",
					"menu-alt-2" => "bars-3-bottom-left",
					"menu-alt-3" => "bars-3-bottom-right",
					"menu-alt-4" => "bars-2",
					"menu" => "bars-3",
					"minus-sm" => nil,
					"music-note" => "musical-note",
					"office-building" => "building-office",
					"pencil-alt" => "pencil-square",
					"phone-incoming" => "phone-arrow-down-left",
					"phone-missed-call" => "phone-x-mark",
					"phone-outgoing" => "phone-arrow-up-right",
					"photograph" => "photo",
					"plus-sm" => nil,
					"puzzle" => "puzzle-piece",
					"qrcode" => "qr-code",
					"receipt-tax" => "receipt-percent",
					"refresh" => "arrow-path",
					"reply" => "arrow-uturn-left",
					"rewind" => "backward",
					"rss" => nil,
					"save-as" => "arrow-down-on-square-stack",
					"save" => "arrow-down-on-square",
					"search-circle" => "magnifying-glass-circle",
					"search" => "magnifying-glass",
					"selector" => nil,
					"sort-ascending" => nil,
					"sort-descending" => nil,
					"speakerphone" => "megaphone",
					"status-offline" => "signal-slash",
					"status-online" => "signal",
					"support" => "lifebuoy",
					"switch-horizontal" => "arrow-right-left",
					"switch-vertical" => "arrow-up-down",
					"table" => "table-cells",
					"template" => "rectangle-group",
					"terminal" => "command-line",
					"thumb-down" => "hand-thumb-down",
					"thumb-up" => "hand-thumb-up",
					"translate" => "language",
					"trending-down" => "arrow-trending-down",
					"trending-up" => "arrow-trending-up",
					"upload" => "arrow-up-tray",
					"user-add" => "user-plus",
					"user-remove" => nil,
					"variable" => nil,
					"view-boards" => "view-columns",
					"view-grid-add" => "squares-plus",
					"view-grid" => "squares-2x2",
					"view-list" => "bars-4",
					"volume-off" => "speaker-x-mark",
					"volume-up" => "speaker-wave",
					"x" => "x-mark",
					"zoom-in" => "magnifying-glass-plus",
					"zoom-out" => "magnifying-glass-minus"
				}
				lookup_table[name] || name
			end

	end
end