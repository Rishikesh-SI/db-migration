-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_provider_author_map labmsg_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labmsg_provider_author_map labmsg_provider_author_map_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_provider_author_map
    ADD CONSTRAINT labmsg_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
