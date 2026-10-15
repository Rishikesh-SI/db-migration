-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_user_language_map labmsg_user_language_map_id
-- Type: CONSTRAINT

-- Name: labmsg_user_language_map labmsg_user_language_map_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_user_language_map
    ADD CONSTRAINT labmsg_user_language_map_id PRIMARY KEY (user_language_map_id);


--
