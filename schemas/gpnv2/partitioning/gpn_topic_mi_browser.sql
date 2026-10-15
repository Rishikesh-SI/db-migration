-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_topic_mi_browser
-- Type: TABLE ATTACH

-- Name: gpn_topic_mi_browser; Type: TABLE ATTACH; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_topic ATTACH PARTITION gpnv2.gpn_topic_mi_browser FOR VALUES IN ('32');


--
