-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_gratification_details
-- Type: TABLE

-- Name: labmi_v1_gratification_details; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_gratification_details (
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
