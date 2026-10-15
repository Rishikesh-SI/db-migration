-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_user_action_tracking_2020
-- Type: TABLE ATTACH

-- Name: labdms_user_action_tracking_2020; Type: TABLE ATTACH; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_user_action_tracking ATTACH PARTITION labdms.labdms_user_action_tracking_2020 FOR VALUES IN ('2020');


--
