-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_bs_income_spend_category
-- Type: TABLE

-- Name: sibot_bs_income_spend_category; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_bs_income_spend_category (
    income_spend_category_id numeric,
    category_id numeric,
    category_name text,
    category character(1),
    category_image_attachment_id text,
    category_description text,
    minimum_amount numeric,
    maximum_amount numeric,
    priority_spend_increase_options numeric[],
    income_change_options numeric[]
);


--
