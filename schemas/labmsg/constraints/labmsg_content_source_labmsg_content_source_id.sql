-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_content_source labmsg_content_source_id
-- Type: CONSTRAINT

-- Name: labmsg_content_source labmsg_content_source_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_content_source
    ADD CONSTRAINT labmsg_content_source_id PRIMARY KEY (content_source_id);


--
