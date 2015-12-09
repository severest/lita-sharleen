require "spec_helper"

describe Lita::Handlers::Sharleen, lita_handler: true do
  it "routes echo" do
    is_expected.to route("echo jojo")
  end
end
