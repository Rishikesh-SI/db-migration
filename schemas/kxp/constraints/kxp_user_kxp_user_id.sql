-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_user kxp_user_id
-- Type: CONSTRAINT

-- Name: kxp_user kxp_user_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_user
    ADD CONSTRAINT kxp_user_id PRIMARY KEY (user_id);


--
