-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_user_action_tracking_202002
-- Type: TABLE ATTACH

-- Name: labdms_user_action_tracking_202002; Type: TABLE ATTACH; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_user_action_tracking_2020 ATTACH PARTITION labdms.labdms_user_action_tracking_202002 FOR VALUES IN ('202002');


--
