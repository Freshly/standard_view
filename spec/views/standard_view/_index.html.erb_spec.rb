# frozen_string_literal: true

require "rails_helper"

RSpec.describe "standard_view/_index.html.erb", type: :view do
  helper(StandardView::ApplicationHelper)
  helper(StandardView::FormattingHelper)
  helper(FakeLawHelper)

  subject(:render_partial) { render partial: "standard_view/index", locals: { facet: facet } }

  let(:facet_class) { TestFacet }
  let(:list_class) { Class.new(Material::List) }
  let(:record_class) { Test }
  let(:facet) { facet_class.new }
  let(:list) { list_class.new }
  let(:list_title) { Faker::Lorem.sentence }
  let(:parameterized_title) { list_title.parameterize }
  let(:collection) { double }

  let(:list_parent?) { list_parent.present? }
  let(:list_parent) { nil }
  let(:facet_filtered?) { false }
  let(:page_content) { nil }

  before do
    list_class.__send__(:ensures_item_class, record_class)

    allow(record_class).to receive(:all).and_return(collection)
    allow(collection).to receive(:paginate).and_return([])
    allow(Material::List).to receive(:for).with(record_class).and_return(list)
    allow(list).to receive(:mount_facet)

    allow(list).to receive(:title).and_return(list_title)
    allow(list).to receive(:parameterized_title).and_return(parameterized_title)
    allow(list).to receive(:parent?).and_return(list_parent?)
    allow(list).to receive(:parent).and_return(list_parent)

    allow(facet).to receive(:filtered?).and_return(facet_filtered?)

    view.instance_variable_get("@view_flow").set(:page_content, page_content) unless page_content.nil?

    allow(view).to receive(:action_name).and_return("index")
    allow(view).to receive(:controller_name).and_return("Test")

    stub_template "standard_view/_breadcrumbs.html.erb" => "_breadcrumb_<%= material.object_id %><br/>"
    stub_template "standard_view/_paginated_collection.html.erb" => "_page_<%= list.object_id %><%= is_filtered %><br/>"
    stub_template "standard_view/_page_content.html.erb" => "_page_content"

    render_partial
  end

  shared_examples_for "an index page is rendered" do
    it "mounts the facet" do
      expect(list).to have_received(:mount_facet).with(an_instance_of(facet_class))
    end

    it "sets content_for title" do
      expect(view.content_for(:title)).to eq list_title
    end

    it "renders <main>" do
      expect(rendered).to have_tag "main##{parameterized_title}-index"
    end

    it "renders <h1>" do
      expect(rendered).to have_tag "h1.mb-3", text: list_title
    end

    it "renders page_content" do
      expect(rendered).to include "_page_content"
    end
  end

  context "with no specified facet" do
    subject(:render_partial) { render partial: "standard_view/index" }

    it_behaves_like "an index page is rendered"
  end

  context "when list.parent?" do
    let(:list_parent) { double(model_name: double(human: parent_human_name)) }
    let(:parent_human_name) { Faker::Lorem.sentence }

    it_behaves_like "an index page is rendered"

    it "renders breadcrumbs" do
      expect(rendered).to include "_breadcrumb_#{list.object_id}"
    end
  end

  context "when not list.parent?" do
    it_behaves_like "an index page is rendered"

    it "doesn't render breadcrumbs" do
      expect(rendered).not_to include "_breadcrumb_#{list.object_id}"
    end
  end

  context "without content_for page_content" do
    shared_examples_for "content_for page_content is set" do
      it "sets content_for page_content" do
        expect(view.content_for(:page_content)).to include "_page_#{list.object_id}#{facet_filtered?}"
      end
    end

    context "when facet.filtered?" do
      let(:facet_filtered?) { true }

      it_behaves_like "an index page is rendered"
      it_behaves_like "content_for page_content is set"
    end

    context "when not facet.filtered?" do
      it_behaves_like "an index page is rendered"
      it_behaves_like "content_for page_content is set"
    end
  end

  context "with content_for page_content" do
    let(:page_content) { "_existing_page_content" }

    shared_examples_for "content_for page_content is NOT set" do
      it "keeps content_for page_content" do
        expect(view.content_for(:page_content)).to eq page_content
      end
    end

    context "when facet.filtered?" do
      let(:facet_filtered?) { true }

      it_behaves_like "an index page is rendered"
      it_behaves_like "content_for page_content is NOT set"
    end

    context "when not facet.filtered?" do
      it_behaves_like "an index page is rendered"
      it_behaves_like "content_for page_content is NOT set"
    end
  end
end
