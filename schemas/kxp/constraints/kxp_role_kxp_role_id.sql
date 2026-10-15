-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_role kxp_role_id
-- Type: CONSTRAINT

-- Name: kxp_role kxp_role_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_role
    ADD CONSTRAINT kxp_role_id PRIMARY KEY (role_id);


--
