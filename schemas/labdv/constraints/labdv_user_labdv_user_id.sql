-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_user labdv_user_id
-- Type: CONSTRAINT

-- Name: labdv_user labdv_user_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_user
    ADD CONSTRAINT labdv_user_id PRIMARY KEY (user_id);


--
