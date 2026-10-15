-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_rating_week mum_rating_week_id
-- Type: CONSTRAINT

-- Name: dhm_rating_week mum_rating_week_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_rating_week
    ADD CONSTRAINT mum_rating_week_id PRIMARY KEY (rating_week_id);


--
