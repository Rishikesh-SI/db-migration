-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_client_event_image
-- Type: TABLE

-- Name: gpn_client_event_image; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_client_event_image (
    client_event_image_id numeric NOT NULL,
    client_id numeric NOT NULL,
    event_id numeric NOT NULL,
    is_image_available numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
