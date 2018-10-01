RSpec.describe "homes/_event_details.html.erb_spec.rb", type: :view do
  it "renders details about the event" do
    event = MeetupEvent.new(event_data)

    render("homes/event_details", event: event)

    expect(rendered).to have_event_name(event.name)

    within_role("event-date-info") do
      expect(rendered).to have_text(event.date)
      expect(rendered).to have_text(event.formatted_start_time)
      expect(rendered).to have_text(event.formatted_end_time)
    end

    within_role("event-venue-info") do
      expect(rendered).to have_text(event.venue_name)
      expect(rendered).to have_text(event.address)
      expect(rendered).to have_text(event.city)
      expect(rendered).to have_text(event.state)
    end

    expect(rendered).to have_link("RSVP", href: event.rsvp_url)
    expect(rendered).to have_link("See all events", href: event.events_url)
  end

  def have_event_name(name)
    have_role_text("event-name", name)
  end

  def event_data
    JSON.parse(
      File.read(Rails.root.join("spec/fixtures/meetup_events.json"))
    ).first
  end
end
