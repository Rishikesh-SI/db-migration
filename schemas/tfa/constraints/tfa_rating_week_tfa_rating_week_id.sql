-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_rating_week tfa_rating_week_id
-- Type: CONSTRAINT

-- Name: tfa_rating_week tfa_rating_week_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_rating_week
    ADD CONSTRAINT tfa_rating_week_id PRIMARY KEY (rating_week_id);


--
