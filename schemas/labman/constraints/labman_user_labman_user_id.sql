-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_user labman_user_id
-- Type: CONSTRAINT

-- Name: labman_user labman_user_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_user
    ADD CONSTRAINT labman_user_id PRIMARY KEY (user_id);


--
