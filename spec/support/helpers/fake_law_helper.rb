module FakeLawHelper
  def law(*)
    ActiveSupport::StringInquirer.new "_"
  end
end
