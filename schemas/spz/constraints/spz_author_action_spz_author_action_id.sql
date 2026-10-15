-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_author_action spz_author_action_id
-- Type: CONSTRAINT

-- Name: spz_author_action spz_author_action_id; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_author_action
    ADD CONSTRAINT spz_author_action_id PRIMARY KEY (author_action_id);


--
