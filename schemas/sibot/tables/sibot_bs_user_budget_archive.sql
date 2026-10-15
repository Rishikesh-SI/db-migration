-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_bs_user_budget_archive
-- Type: TABLE

-- Name: sibot_bs_user_budget_archive; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_bs_user_budget_archive (
    user_budget_id numeric,
    user_id numeric,
    category_id numeric,
    category character(1),
    is_priority numeric,
    base_amount numeric,
    target_amount numeric,
    change_option character(1),
    change_value numeric,
    is_success numeric,
    play_id numeric,
    play_date timestamp without time zone
);


--
