-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_press_release mum_press_release_id
-- Type: CONSTRAINT

-- Name: dhm_press_release mum_press_release_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_press_release
    ADD CONSTRAINT mum_press_release_id PRIMARY KEY (press_release_id);


--
