-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_user_role labwis_user_role_id
-- Type: CONSTRAINT

-- Name: labwis_user_role labwis_user_role_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_user_role
    ADD CONSTRAINT labwis_user_role_id PRIMARY KEY (user_role_id);


--
