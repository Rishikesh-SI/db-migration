-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_user yho_user_id
-- Type: CONSTRAINT

-- Name: yho_user yho_user_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_user
    ADD CONSTRAINT yho_user_id PRIMARY KEY (user_id);


--
