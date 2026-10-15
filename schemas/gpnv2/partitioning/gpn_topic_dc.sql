-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_topic_dc
-- Type: TABLE ATTACH

-- Name: gpn_topic_dc; Type: TABLE ATTACH; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_topic ATTACH PARTITION gpnv2.gpn_topic_dc FOR VALUES IN ('25', '26', '27');


--
