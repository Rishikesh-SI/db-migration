-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_jfc
-- Type: TABLE ATTACH

-- Name: gpn_user_jfc; Type: TABLE ATTACH; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_user ATTACH PARTITION gpnv2.gpn_user_jfc FOR VALUES IN ('22', '23', '24');


--
