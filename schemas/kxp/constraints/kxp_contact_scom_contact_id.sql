-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: kxp_contact scom_contact_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
