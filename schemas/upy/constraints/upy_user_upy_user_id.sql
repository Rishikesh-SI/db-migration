-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_user upy_user_id
-- Type: CONSTRAINT

-- Name: upy_user upy_user_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_user
    ADD CONSTRAINT upy_user_id PRIMARY KEY (user_id);


--
