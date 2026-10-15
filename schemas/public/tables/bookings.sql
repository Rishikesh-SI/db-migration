-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: bookings
-- Type: TABLE

-- Name: bookings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookings (
    room_id numeric,
    booking_id numeric,
    start_time timestamp without time zone,
    end_time timestamp without time zone
);


--
