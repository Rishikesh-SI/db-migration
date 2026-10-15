-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_author_action kxp_author_action_id
-- Type: CONSTRAINT

-- Name: kxp_author_action kxp_author_action_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_author_action
    ADD CONSTRAINT kxp_author_action_id PRIMARY KEY (author_action_id);


--
