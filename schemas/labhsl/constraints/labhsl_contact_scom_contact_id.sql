-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labhsl_contact scom_contact_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
