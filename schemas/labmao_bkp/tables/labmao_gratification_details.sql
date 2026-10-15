-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_gratification_details
-- Type: TABLE

-- Name: labmao_gratification_details; Type: TABLE; Schema: labmao_bkp; Owner: -
--

CREATE TABLE labmao_bkp.labmao_gratification_details (
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
