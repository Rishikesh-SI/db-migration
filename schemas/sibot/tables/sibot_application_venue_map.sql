-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_venue_map
-- Type: TABLE

-- Name: sibot_application_venue_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_venue_map (
    application_venue_map_id numeric,
    application_id numeric,
    venue_id numeric,
    venue_image_url text,
    location_image_url text,
    location_url text,
    parking_image_attachment_id text,
    facilities_image_attachment_id text,
    facilities_text text,
    parking_text text,
    venue_slno numeric
);


--
