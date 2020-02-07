module StandardView
  module BadgeHelper
    def badge(content, type: "dark", right: false, pill: false, extra_class: nil, **options)
      extra = "#{"badge-pill" if pill} #{"float-right mt-1 ml-2" if right} #{extra_class}"
      content_tag :span, content, class: "badge badge-#{type} #{extra}", **options
    end

    def count_badge(value, type: "dark", extra_class: "ml-1", **options)
      number = value.respond_to?(:count) ? value.count : value
      badge_type = block_given? ? yield(number) : type
      badge number_with_delimiter(number), type: badge_type, extra_class: extra_class, **options
    end

    def unread_badge(value, **options)
      count_badge(value, **options) { |number| number.zero? ? "dark" : "danger" }
    end

    def boolean_badge(is, **options)
      badge t(is ? "common.on" : "common.off"), type: is ? "success" : "danger", **options
    end
  end
end
