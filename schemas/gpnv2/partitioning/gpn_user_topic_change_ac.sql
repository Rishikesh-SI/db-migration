-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_topic_change_ac
-- Type: TABLE ATTACH

-- Name: gpn_user_topic_change_ac; Type: TABLE ATTACH; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_user_topic_change ATTACH PARTITION gpnv2.gpn_user_topic_change_ac FOR VALUES IN ('28', '29', '30');


--
