-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_bs_budget_failure_scenario
-- Type: TABLE

-- Name: sibot_bs_budget_failure_scenario; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_bs_budget_failure_scenario (
    scenario_id numeric,
    scenario_description text,
    scenario_message text,
    priority numeric
);


--
