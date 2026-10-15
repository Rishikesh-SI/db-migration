-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_user mum_user_id
-- Type: CONSTRAINT

-- Name: dhm_user mum_user_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_user
    ADD CONSTRAINT mum_user_id PRIMARY KEY (user_id);


--
