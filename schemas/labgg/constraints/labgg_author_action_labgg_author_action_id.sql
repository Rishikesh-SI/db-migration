-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_author_action labgg_author_action_id
-- Type: CONSTRAINT

-- Name: labgg_author_action labgg_author_action_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_author_action
    ADD CONSTRAINT labgg_author_action_id PRIMARY KEY (author_action_id);


--
