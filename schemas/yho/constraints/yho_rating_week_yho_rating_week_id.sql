-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_rating_week yho_rating_week_id
-- Type: CONSTRAINT

-- Name: yho_rating_week yho_rating_week_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_rating_week
    ADD CONSTRAINT yho_rating_week_id PRIMARY KEY (rating_week_id);


--
