-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_user labsm_user_id
-- Type: CONSTRAINT

-- Name: labsm_user labsm_user_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_user
    ADD CONSTRAINT labsm_user_id PRIMARY KEY (user_id);


--
