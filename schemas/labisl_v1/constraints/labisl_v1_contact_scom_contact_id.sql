-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labisl_v1_contact scom_contact_id; Type: CONSTRAINT; Schema: labisl_v1; Owner: -
--

ALTER TABLE ONLY labisl_v1.labisl_v1_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
