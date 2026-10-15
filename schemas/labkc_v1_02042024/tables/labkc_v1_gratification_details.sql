-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_gratification_details
-- Type: TABLE

-- Name: labkc_v1_gratification_details; Type: TABLE; Schema: labkc_v1_02042024; Owner: -
--

CREATE TABLE labkc_v1_02042024.labkc_v1_gratification_details (
    gratification_detail_id numeric NOT NULL,
    user_id numeric,
    event_id numeric,
    nth_num numeric,
    gift_id numeric,
    is_active numeric,
    is_deleted numeric,
    is_claimed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
