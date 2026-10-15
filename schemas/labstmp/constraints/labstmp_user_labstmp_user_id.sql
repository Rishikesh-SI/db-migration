-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_user labstmp_user_id
-- Type: CONSTRAINT

-- Name: labstmp_user labstmp_user_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_user
    ADD CONSTRAINT labstmp_user_id PRIMARY KEY (user_id);


--
