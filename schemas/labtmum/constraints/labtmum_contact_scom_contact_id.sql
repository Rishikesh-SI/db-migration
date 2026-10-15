-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labtmum_contact scom_contact_id; Type: CONSTRAINT; Schema: labtmum; Owner: -
--

ALTER TABLE ONLY labtmum.labtmum_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
